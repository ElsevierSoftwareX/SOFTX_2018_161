# distutils: language=c++
"""
Copyright 2018 CCPi
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Author: Edoardo Pasca, Daniil Kazantsev
"""

import cython
import numpy as np
cimport numpy as np

cdef extern float TV_ROF_CPU_main(float *Input, float *Output, float lambdaPar, int iterationsNumb, float tau, int dimX, int dimY, int dimZ);
cdef extern float TV_FGP_CPU_main(float *Input, float *Output, float lambdaPar, int iterationsNumb, float epsil, int methodTV, int nonneg, int printM, int dimX, int dimY, int dimZ);
cdef extern float TV_SB_CPU_main(float *Input, float *Output, float lambdaPar, int iterationsNumb, float epsil, int methodTV, int printM, int dimX, int dimY, int dimZ);
cdef extern float dTV_FGP_CPU_main(float *Input, float *InputRef, float *Output, float lambdaPar, int iterationsNumb, float epsil, float eta, int methodTV, int nonneg, int printM, int dimX, int dimY, int dimZ);


#****************************************************************#
#********************** Total-variation ROF *********************#
#****************************************************************#
def TV_ROF_CPU(inputData, regularisation_parameter, iterationsNumb, marching_step_parameter):
    if inputData.ndim == 2:
        return TV_ROF_2D(inputData, regularisation_parameter, iterationsNumb, marching_step_parameter)
    elif inputData.ndim == 3:
        return TV_ROF_3D(inputData, regularisation_parameter, iterationsNumb, marching_step_parameter)

def TV_ROF_2D(np.ndarray[np.float32_t, ndim=2, mode="c"] inputData, 
                     float regularisation_parameter,
                     int iterationsNumb,                     
                     float marching_step_parameter):
    cdef long dims[2]
    dims[0] = inputData.shape[0]
    dims[1] = inputData.shape[1]
    
    cdef np.ndarray[np.float32_t, ndim=2, mode="c"] outputData = \
            np.zeros([dims[0],dims[1]], dtype='float32')
                   
    # Run ROF iterations for 2D data 
    TV_ROF_CPU_main(&inputData[0,0], &outputData[0,0], regularisation_parameter, iterationsNumb, marching_step_parameter, dims[0], dims[1], 1)
    
    return outputData
            
def TV_ROF_3D(np.ndarray[np.float32_t, ndim=3, mode="c"] inputData, 
                     float regularisation_parameter,
                     int iterationsNumb,
                     float marching_step_parameter):
    cdef long dims[3]
    dims[0] = inputData.shape[0]
    dims[1] = inputData.shape[1]
    dims[2] = inputData.shape[2]
    
    cdef np.ndarray[np.float32_t, ndim=3, mode="c"] outputData = \
            np.zeros([dims[0],dims[1],dims[2]], dtype='float32')
           
    # Run ROF iterations for 3D data 
    TV_ROF_CPU_main(&inputData[0,0,0], &outputData[0,0,0], regularisation_parameter, iterationsNumb, marching_step_parameter, dims[2], dims[1], dims[0])

    return outputData

#****************************************************************#
#********************** Total-variation FGP *********************#
#****************************************************************#
#******** Total-variation Fast-Gradient-Projection (FGP)*********#
def TV_FGP_CPU(inputData, regularisation_parameter, iterationsNumb, tolerance_param, methodTV, nonneg, printM):
    if inputData.ndim == 2:
        return TV_FGP_2D(inputData, regularisation_parameter, iterationsNumb, tolerance_param, methodTV, nonneg, printM)
    elif inputData.ndim == 3:
        return TV_FGP_3D(inputData, regularisation_parameter, iterationsNumb, tolerance_param, methodTV, nonneg, printM)

def TV_FGP_2D(np.ndarray[np.float32_t, ndim=2, mode="c"] inputData, 
                     float regularisation_parameter,
                     int iterationsNumb, 
                     float tolerance_param,
                     int methodTV,
                     int nonneg,
                     int printM):
                         
    cdef long dims[2]
    dims[0] = inputData.shape[0]
    dims[1] = inputData.shape[1]
    
    cdef np.ndarray[np.float32_t, ndim=2, mode="c"] outputData = \
            np.zeros([dims[0],dims[1]], dtype='float32')
                   
    #/* Run FGP-TV iterations for 2D data */
    TV_FGP_CPU_main(&inputData[0,0], &outputData[0,0], regularisation_parameter, 
                       iterationsNumb, 
                       tolerance_param,
                       methodTV,
                       nonneg,
                       printM,
                       dims[0], dims[1], 1)
    
    return outputData        
            
def TV_FGP_3D(np.ndarray[np.float32_t, ndim=3, mode="c"] inputData, 
                     float regularisation_parameter,
                     int iterationsNumb, 
                     float tolerance_param,
                     int methodTV,
                     int nonneg,
                     int printM):
    cdef long dims[3]
    dims[0] = inputData.shape[0]
    dims[1] = inputData.shape[1]
    dims[2] = inputData.shape[2]
    
    cdef np.ndarray[np.float32_t, ndim=3, mode="c"] outputData = \
            np.zeros([dims[0], dims[1], dims[2]], dtype='float32')
           
    #/* Run FGP-TV iterations for 3D data */
    TV_FGP_CPU_main(&inputData[0,0,0], &outputData[0,0,0], regularisation_parameter,
                       iterationsNumb, 
                       tolerance_param,
                       methodTV,
                       nonneg,
                       printM,
                       dims[2], dims[1], dims[0])
    return outputData 

#***************************************************************#
#********************** Total-variation SB *********************#
#***************************************************************#
#*************** Total-variation Split Bregman (SB)*************#
def TV_SB_CPU(inputData, regularisation_parameter, iterationsNumb, tolerance_param, methodTV, printM):
    if inputData.ndim == 2:
        return TV_SB_2D(inputData, regularisation_parameter, iterationsNumb, tolerance_param, methodTV, printM)
    elif inputData.ndim == 3:
        return TV_SB_3D(inputData, regularisation_parameter, iterationsNumb, tolerance_param, methodTV, printM)

def TV_SB_2D(np.ndarray[np.float32_t, ndim=2, mode="c"] inputData, 
                     float regularisation_parameter,
                     int iterationsNumb, 
                     float tolerance_param,
                     int methodTV,
                     int printM):
                         
    cdef long dims[2]
    dims[0] = inputData.shape[0]
    dims[1] = inputData.shape[1]
    
    cdef np.ndarray[np.float32_t, ndim=2, mode="c"] outputData = \
            np.zeros([dims[0],dims[1]], dtype='float32')
                   
    #/* Run SB-TV iterations for 2D data */
    TV_SB_CPU_main(&inputData[0,0], &outputData[0,0], regularisation_parameter, 
                       iterationsNumb, 
                       tolerance_param,
                       methodTV,
                       printM,
                       dims[0], dims[1], 1)
    
    return outputData        
            
def TV_SB_3D(np.ndarray[np.float32_t, ndim=3, mode="c"] inputData, 
                     float regularisation_parameter,
                     int iterationsNumb, 
                     float tolerance_param,
                     int methodTV,
                     int printM):
    cdef long dims[3]
    dims[0] = inputData.shape[0]
    dims[1] = inputData.shape[1]
    dims[2] = inputData.shape[2]
    
    cdef np.ndarray[np.float32_t, ndim=3, mode="c"] outputData = \
            np.zeros([dims[0], dims[1], dims[2]], dtype='float32')
           
    #/* Run SB-TV iterations for 3D data */
    TV_SB_CPU_main(&inputData[0,0,0], &outputData[0,0,0], regularisation_parameter,
                       iterationsNumb, 
                       tolerance_param,
                       methodTV,
                       printM,
                       dims[2], dims[1], dims[0])
    return outputData 
#****************************************************************#
#**************Directional Total-variation FGP ******************#
#****************************************************************#
#******** Directional TV Fast-Gradient-Projection (FGP)*********#
def dTV_FGP_CPU(inputData, refdata, regularisation_parameter, iterationsNumb, tolerance_param, eta_const, methodTV, nonneg, printM):
    if inputData.ndim == 2:
        return dTV_FGP_2D(inputData, refdata, regularisation_parameter, iterationsNumb, tolerance_param, eta_const, methodTV, nonneg, printM)
    elif inputData.ndim == 3:
        return dTV_FGP_3D(inputData, refdata, regularisation_parameter, iterationsNumb, tolerance_param, eta_const, methodTV, nonneg, printM)

def dTV_FGP_2D(np.ndarray[np.float32_t, ndim=2, mode="c"] inputData, 
               np.ndarray[np.float32_t, ndim=2, mode="c"] refdata,
                     float regularisation_parameter,
                     int iterationsNumb, 
                     float tolerance_param,
                     float eta_const,
                     int methodTV,
                     int nonneg,
                     int printM):
                         
    cdef long dims[2]
    dims[0] = inputData.shape[0]
    dims[1] = inputData.shape[1]
    
    cdef np.ndarray[np.float32_t, ndim=2, mode="c"] outputData = \
            np.zeros([dims[0],dims[1]], dtype='float32')
                   
    #/* Run FGP-dTV iterations for 2D data */
    dTV_FGP_CPU_main(&inputData[0,0], &refdata[0,0], &outputData[0,0], regularisation_parameter, 
                       iterationsNumb, 
                       tolerance_param,
                       eta_const,
                       methodTV,                       
                       nonneg,
                       printM,
                       dims[0], dims[1], 1)
    
    return outputData        
            
def dTV_FGP_3D(np.ndarray[np.float32_t, ndim=3, mode="c"] inputData,
               np.ndarray[np.float32_t, ndim=3, mode="c"] refdata,
                     float regularisation_parameter,
                     int iterationsNumb, 
                     float tolerance_param,
                     float eta_const,
                     int methodTV,
                     int nonneg,
                     int printM):
    cdef long dims[3]
    dims[0] = inputData.shape[0]
    dims[1] = inputData.shape[1]
    dims[2] = inputData.shape[2]
    
    cdef np.ndarray[np.float32_t, ndim=3, mode="c"] outputData = \
            np.zeros([dims[0], dims[1], dims[2]], dtype='float32')
           
    #/* Run FGP-dTV iterations for 3D data */
    dTV_FGP_CPU_main(&inputData[0,0,0], &refdata[0,0,0], &outputData[0,0,0], regularisation_parameter,
                       iterationsNumb, 
                       tolerance_param,
                       eta_const,
                       methodTV,
                       nonneg,
                       printM,
                       dims[2], dims[1], dims[0])
    return outputData

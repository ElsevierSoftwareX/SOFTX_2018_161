"""
script which assigns a proper device core function based on a flag ('cpu' or 'gpu')
"""

from ccpi.filters.cpu_regularisers import TV_ROF_CPU, TV_FGP_CPU, TV_SB_CPU, dTV_FGP_CPU, TNV_CPU, NDF_CPU, NDF_INPAINT_CPU, NVM_INPAINT_CPU
from ccpi.filters.gpu_regularisers import TV_ROF_GPU, TV_FGP_GPU, TV_SB_GPU, dTV_FGP_GPU, NDF_GPU

def ROF_TV(inputData, regularisation_parameter, iterations,
                     time_marching_parameter,device='cpu'):
    if device == 'cpu':
        return TV_ROF_CPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     time_marching_parameter)
    elif device == 'gpu':
        return TV_ROF_GPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     time_marching_parameter)
    else:
        raise ValueError('Unknown device {0}. Expecting gpu or cpu'\
                         .format(device))

def FGP_TV(inputData, regularisation_parameter,iterations,
                     tolerance_param, methodTV, nonneg, printM, device='cpu'):
    if device == 'cpu':
        return TV_FGP_CPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     methodTV,
                     nonneg,
                     printM)
    elif device == 'gpu':
        return TV_FGP_GPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     methodTV,
                     nonneg,
                     printM)
    else:
        raise ValueError('Unknown device {0}. Expecting gpu or cpu'\
                         .format(device))
def SB_TV(inputData, regularisation_parameter, iterations,
                     tolerance_param, methodTV, printM, device='cpu'):
    if device == 'cpu':
        return TV_SB_CPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     methodTV,
                     printM)
    elif device == 'gpu':
        return TV_SB_GPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     methodTV,
                     printM)
    else:
        raise ValueError('Unknown device {0}. Expecting gpu or cpu'\
                         .format(device))
def FGP_dTV(inputData, refdata, regularisation_parameter, iterations,
                     tolerance_param, eta_const, methodTV, nonneg, printM, device='cpu'):
    if device == 'cpu':
        return dTV_FGP_CPU(inputData,
                     refdata,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     eta_const,
                     methodTV,
                     nonneg,
                     printM)
    elif device == 'gpu':
        return dTV_FGP_GPU(inputData,
                     refdata,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     eta_const,
                     methodTV,
                     nonneg,
                     printM)
    else:
        raise ValueError('Unknown device {0}. Expecting gpu or cpu'\
                         .format(device))
def TNV(inputData, regularisation_parameter, iterations, tolerance_param):
        return TNV_CPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param)
def NDF(inputData, regularisation_parameter, edge_parameter, iterations,
                     time_marching_parameter, penalty_type, device='cpu'):
    if device == 'cpu':
        return NDF_CPU(inputData,
                     regularisation_parameter,
                     edge_parameter,
                     iterations, 
                     time_marching_parameter,
                     penalty_type)
    elif device == 'gpu':
        return NDF_GPU(inputData,
                     regularisation_parameter,
                     edge_parameter,
                     iterations, 
                     time_marching_parameter,
                     penalty_type)
    else:
        raise ValueError('Unknown device {0}. Expecting gpu or cpu'\
                         .format(device))
def NDF_INP(inputData, maskData, regularisation_parameter, edge_parameter, iterations,
                     time_marching_parameter, penalty_type):
        return NDF_INPAINT_CPU(inputData, maskData, regularisation_parameter, 
        edge_parameter, iterations, time_marching_parameter, penalty_type)
        
def NVM_INP(inputData, maskData, SW_increment, iterations):
        return NVM_INPAINT_CPU(inputData, maskData, SW_increment, iterations)
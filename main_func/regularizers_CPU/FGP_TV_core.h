/*
This work is part of the Core Imaging Library developed by
Visual Analytics and Imaging System Group of the Science Technology
Facilities Council, STFC

Copyright 2017 Daniil Kazanteev
Copyright 2017 Srikanth Nagella, Edoardo Pasca

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

#include <matrix.h>
#include <math.h>
#include <stdlib.h>
#include <memory.h>
#include <stdio.h>
#include "omp.h"

float copyIm(float *A, float *B, int dimX, int dimY, int dimZ);
float Obj_func2D(float *A, float *D, float *R1, float *R2, float lambda, int dimX, int dimY);
float Grad_func2D(float *P1, float *P2, float *D, float *R1, float *R2, float lambda, int dimX, int dimY);
float Proj_func2D(float *P1, float *P2, int methTV, int dimX, int dimY);
float Rupd_func2D(float *P1, float *P1_old, float *P2, float *P2_old, float *R1, float *R2, float tkp1, float tk, int dimX, int dimY);
float Obj_func_CALC2D(float *A, float *D, float *funcvalA, float lambda, int dimX, int dimY);

float Obj_func3D(float *A, float *D, float *R1, float *R2, float *R3, float lambda, int dimX, int dimY, int dimZ);
float Grad_func3D(float *P1, float *P2, float *P3, float *D, float *R1, float *R2, float *R3, float lambda, int dimX, int dimY, int dimZ);
float Proj_func3D(float *P1, float *P2, float *P3, int dimX, int dimY, int dimZ);
float Rupd_func3D(float *P1, float *P1_old, float *P2, float *P2_old, float *P3, float *P3_old, float *R1, float *R2, float *R3, float tkp1, float tk, int dimX, int dimY, int dimZ);
float Obj_func_CALC3D(float *A, float *D, float *funcvalA, float lambda, int dimX, int dimY, int dimZ);

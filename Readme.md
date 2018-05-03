# CCPi-Regularisation Toolkit (CCPi-RGL)

**Iterative image reconstruction (IIR) methods normally require regularisation to stabilise the convergence and make the reconstruction problem more well-posed. CCPi-RGL software consists of 2D/3D regularisation modules for single-channel and multi-channel reconstruction problems. The regularisation modules are well-suited to use with [splitting algorithms](https://en.wikipedia.org/wiki/Augmented_Lagrangian_method#Alternating_direction_method_of_multipliers), such as ADMM and FISTA. Furthermore, the toolkit can be used independently to solve image denoising and inpaiting tasks. The core modules are written in C-OMP and CUDA languages, wrappers for Matlab and Python are provided.** 

<div align="center">
  <img src="docs/images/probl.png" height="225"><br>  
</div>

## Prerequisites: 

 * [MATLAB](www.mathworks.com/products/matlab/) OR
 * Python (tested ver. 3.5); Cython
 * C compilers
 * nvcc (CUDA SDK) compilers

## Package modules:

### Single-channel (denoising):
1. Rudin-Osher-Fatemi (ROF) Total Variation (explicit PDE minimisation scheme) **2D/3D CPU/GPU** (Ref. *1*)
2. Fast-Gradient-Projection (FGP) Total Variation **2D/3D CPU/GPU** (Ref. *2*)
3. Split-Bregman (SB) Total Variation **2D/3D CPU/GPU** (Ref. *5*)
4. Linear and nonlinear diffusion (explicit PDE minimisation scheme) **2D/3D CPU/GPU** (Ref. *7*)

### Multi-channel (denoising):
1. Fast-Gradient-Projection (FGP) Directional Total Variation **2D/3D CPU/GPU** (Ref. *3,4,2*)
2. Total Nuclear Variation (TNV) penalty **2D+channels CPU** (Ref. *6*)

### Inpainting:
1. Linear and nonlinear diffusion (explicit PDE minimisation scheme) **2D/3D CPU** (Ref. *7*)
2. Iterative nonlocal vertical marching method  **2D CPU**


## Installation:

### Python (conda-build)
```
	export CIL_VERSION=0.9.2
	conda build recipes/regularisers --numpy 1.12 --python 3.5 
	conda install cil_regulariser=0.9.2 --use-local --force
	cd Wrappers/Python
	conda build conda-recipe --numpy 1.12 --python 3.5 
	conda install ccpi-regulariser=0.9.2 --use-local --force
	cd demos/
	python demo_cpu_regularisers.py # to run CPU demo
	python demo_gpu_regularisers.py # to run GPU demo
```
### Matlab
```
	cd /Wrappers/Matlab/mex_compile
	compileCPU_mex.m % to compile CPU modules
	compileGPU_mex.m % to compile GPU modules (see instructions in the file)
```

### References:
*1. [Rudin, L.I., Osher, S. and Fatemi, E., 1992. Nonlinear total variation based noise removal algorithms. Physica D: nonlinear phenomena, 60(1-4), pp.259-268.](https://doi.org/10.1016/0167-2789(92)90242-F)*

*2. [Beck, A. and Teboulle, M., 2009. Fast gradient-based algorithms for constrained total variation image denoising and deblurring problems. IEEE Transactions on Image Processing, 18(11), pp.2419-2434.](https://doi.org/10.1109/TIP.2009.2028250)*

*3. [Ehrhardt, M.J. and Betcke, M.M., 2016. Multicontrast MRI reconstruction with structure-guided total variation. SIAM Journal on Imaging Sciences, 9(3), pp.1084-1106.](https://doi.org/10.1137/15M1047325)*

*4. [Kazantsev, D., Jørgensen, J.S., Andersen, M., Lionheart, W.R., Lee, P.D. and Withers, P.J., 2018. Joint image reconstruction method with correlative multi-channel prior for X-ray spectral computed tomography. Inverse Problems, 34(6)](https://doi.org/10.1088/1361-6420/aaba86)* [CODE to reproduce results](https://github.com/dkazanc/multi-channel-X-ray-CT)

*5. [Goldstein, T. and Osher, S., 2009. The split Bregman method for L1-regularized problems. SIAM journal on imaging sciences, 2(2), pp.323-343.](https://doi.org/10.1137/080725891)*

*6. [Duran, J., Moeller, M., Sbert, C. and Cremers, D., 2016. Collaborative total variation: a general framework for vectorial TV models. SIAM Journal on Imaging Sciences, 9(1), pp.116-151.](https://doi.org/10.1137/15M102873X)*

*7. [Black, M.J., Sapiro, G., Marimont, D.H. and Heeger, D., 1998. Robust anisotropic diffusion. IEEE Transactions on image processing, 7(3), pp.421-432.](https://doi.org/10.1109/83.661192)*

### License:
[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

### Acknowledgments:
CCPi-RGL software is a product of the [CCPi](https://www.ccpi.ac.uk/) group and STFC SCD software developers. Any relevant questions/comments can be e-mailed to Daniil Kazantsev at dkazanc@hotmail.com

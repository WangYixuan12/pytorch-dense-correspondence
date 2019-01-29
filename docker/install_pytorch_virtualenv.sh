#!/bin/bash
#
# This script is run by the dockerfile during the docker build.
#

set -ex

root_dir=$(pwd)


virtual_env_folder=$PYTORCH_VIRTUALENV_DIR


pip install virtualenv
virtualenv $virtual_env_folder # create virtualenv
source $virtual_env_folder/bin/activate # activate virtualenv

venv_pip=$virtual_env_folder/bin/pip
venv_python=$virtual_env_folder/bin/python


# it seems these are needed following the suggestions here
# https://stackoverflow.com/questions/48561981/activate-python-virtualenv-in-dockerfile?rq=1
$venv_pip install ipython
$venv_pip install jupyter



# install pytorch 1.0 nightly
$venv_pip install numpy torchvision_nightly
$venv_pip install torch_nightly -f https://download.pytorch.org/whl/nightly/cu90/torch_nightly.html


# maskrcnn_benchmark and coco api dependencies
$venv_pip install ninja yacs cython matplotlib
$venv_pip install \
    requests \
    opencv-python

# create director for stashing some dependencies
cd $root_dir
mkdir github_venv

# install torchvision
cd $root_dir/github_venv
git clone https://github.com/pytorch/vision.git
cd vision
python setup.py install

# install pycocotools
cd $root_dir/github_venv
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
python setup.py build_ext install


install_maskrcnn_benchmark(){
	# install PyTorch Detection
	# do this once you launch the container
	cd $root_dir/github_venv
	git clone https://github.com/facebookresearch/maskrcnn-benchmark.git
	cd maskrcnn-benchmark
	git checkout 5f2a8263a1a0f2f5f0137042cd4ba64efcb6859a
	# the following will install the lib with
	# symbolic links, so that you can modify
	# the files if you want and won't need to
	# re-build it
	python setup.py build develop	
}

deactivate


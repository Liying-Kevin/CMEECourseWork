import os
import gzip
import _pickle as pickle

import numpy as np
import scipy.stats
import pymc3

import tensorflow as tf 
from tensorflow import keras #high-level neural networks API
from keras import models, layers, activations, optimizers, regularizers
from keras.utils import plot_model
from keras.models import load_model

import itertools #create iterator for looping
import matplotlib.pyplot as plt
import skimage.transform #image process
from sklearn.metrics import confusion_matrix
import pydot # optional, but required by keras to plot the model

%run -i ImaGene.py

file_LCT = ImaFile(nr_samples=198, VCF_file_name="../data/LCT.CEU.vcf")

gene_LCT = file_LCT.read_VCF()

gene_LCT.summary()

gene_LCT.filter_freq(0.01)

gene_LCT.plot()

#gene_LCT.sort?
gene_LCT.sort('rows_freq')
gene_LCT.plot()

gene_LCT.convert(flip=True)
gene_LCT.plot()
gene_LCT.summary()
gene_LCT.save(file='../data/gene_LCT')
gene_LCT = load_imagene(file='../data/gene_LCT')

gene_LCT.convert(flip=True)
gene_LCT.plot()
gene_LCT.summary()


import subprocess
subprocess.call("bash ../code/generate_dataset.sh params_binary.txt".split())
file_sim = ImaFile(simulations_folder='../data/simulation', nr_samples=198, model_name='Marth-3epoch-CEU')
gene_sim = file_sim.read_simulations(parameter_name='recombination_rate', max_nrepl=200)
gene_sim.summary()

import os
import gzip
import _pickle as pickle

import numpy as np
import scipy.stats
import pymc3

import tensorflow as tf

from tensorflow import keras
from keras import models, layers, activations, optimizers, regularizers
from keras.utils import plot_model
from keras.models import load_model

import itertools
import skimage.transform
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
import pydot # optional, but required by keras to plot the model

%run -i ImaGene.py

file_LCT = ImaFile(nr_samples=67, VCF_file_name='../data/snp.new.vcf')
gene_LCT = file_LCT.read_VCF(verbose=1)

gene_LCT.majorminor()
gene_LCT.filter_freq(0.015)

gene_LCT.summary()
gene_LCT.plot()

gene_LCT.sort('rows_dist')
gene_LCT.plot()


import subprocess
subprocess.call("bash ../code/generate_dataset.sh params.txt".split())
file_sim = ImaFile(simulations_folder='/Users/kevin/CMEECourseWork/final_project/data/simulation/Simulations1', nr_samples=67, model_name='Marth-3epoch-CEU')
gene_sim = file_sim.read_simulations(parameter_name='recombination_rate', max_nrepl=200)
gene_sim.summary()
gene_sim.plot(0)

gene_sim.majorminor()
gene_sim.filter_freq(0.01)
gene_sim.sort('rows_dist')
gene_sim.plot(0)
gene_sim.resize((67,205))
#gene_sim.resize('mean')
#?gene_sim.
gene_sim.convert()

gene_sim.classes = np.array([20,40,60])
gene_sim.subset(get_index_classes(gene_sim.targets, gene_sim.classes))
gene_sim.summary()
gene_sim.targets
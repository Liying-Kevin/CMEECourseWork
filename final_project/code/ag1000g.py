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
#import pydot # optional, but required by keras to plot the model

%run -i ImaGene.py

file_LCT = ImaFile(nr_samples=67, VCF_file_name='../data/snp.new.vcf')
gene_LCT = file_LCT.read_VCF(verbose=1)

gene_LCT.majorminor()
gene_LCT.filter_freq(0.015)

gene_LCT.summary()
gene_LCT.plot()

gene_LCT.sort('rows_freq')
#gene_LCT.plot()

path = '/Users/kevin/CMEECourseWork/final_project/'

import subprocess
subprocess.call("bash ../code/generate_dataset.sh params.txt".split())
    #file_sim = ImaFile(simulations_folder='/Users/kevin/CMEECourseWork/final_project/data/simulation/Simulations1', nr_samples=67, model_name='Marth-3epoch-CEU')
#freqs = calculate_allele_frequency(gene_sim,0.5)
#plt.scatter(gene_sim. targets, freqs, marker='o')
#plt.xlabel('Selectin coefficient')
#plt.ylabel('Allele frequency')

i=1
while i<=10:


    file_sim = ImaFile(simulations_folder=path+'data/simulation/Simulations' + str(i), nr_samples=67, model_name='Marth-3epoch-CEU')
    gene_sim = file_sim.read_simulations(parameter_name='recombination_rate', max_nrepl=200)
    gene_sim.summary()
    #gene_sim.plot()
    gene_sim.majorminor()
    gene_sim.filter_freq(0.015)
    #gene_sim.plot()
    gene_sim.sort('rows_dist')

    #gene_sim.plot()
    gene_sim.resize((67,205))
    #gene_sim.resize('mean')
    #?gene_sim.sort
    gene_sim.convert() 


    gene_sim.classes = np.array([20,40,60])
    gene_sim.subset(get_index_classes(gene_sim.targets, gene_sim.classes))

    gene_sim.subset(get_index_random(gene_sim))

    gene_sim.targets = to_categorical(gene_sim.targets)

    if i == 1:

            model = models.Sequential([
                        layers.Conv2D(filters=64, kernel_size=(3,3), strides=(1,1), activation='relu', kernel_regularizer=regularizers.l1_l2(l1=0.005, l2=0.005), padding='valid', input_shape=gene_sim.data.shape[1:]),
                        layers.MaxPooling2D(pool_size=(2,2)),
                        layers.Conv2D(filters=64, kernel_size=(3,3), strides=(1,1), activation='relu', kernel_regularizer=regularizers.l1_l2(l1=0.005, l2=0.005), padding='valid'),
                        layers.MaxPooling2D(pool_size=(2,2)),
                        layers.Conv2D(filters=128, kernel_size=(3,3), strides=(1,1), activation='relu', kernel_regularizer=regularizers.l1_l2(l1=0.005, l2=0.005), padding='valid'),
                        layers.MaxPooling2D(pool_size=(2,2)),
                        layers.Flatten(),
                        layers.Dense(units=128, activation='relu'),
                        layers.Dense(units=len(gene_sim.classes), activation='softmax')])
            model.compile(optimizer='adam',
                        loss='categorical_crossentropy',
                        metrics=['accuracy'])

            net_LCT = ImaNet(name='[C32+P]+[C64+P]x2+D128')

        # training for iterations from 1 to 9
    if i < 10:
            score = model.fit(gene_sim.data, gene_sim.targets, batch_size=32, epochs=1, verbose=1, validation_split=0.10)
            net_LCT.update_scores(score)
    else:
            # testing for iteration 10
            net_LCT.test = model.evaluate(gene_sim.data, gene_sim.targets, batch_size=None, verbose=0)
            net_LCT.predict(gene_sim, model)

    i += 1

# save final (trained) model
model.save(path+'data/model.multi.h5')

# save testing data
gene_sim.save(path+'data/gene_sim.multi')

# save network
net_LCT.save(path+'data/net_LCT.multi')



model = load_model(path+'data/model.multi.h5')
gene_sim = load_imagene(file=path+'data/gene_sim.multi')
net_LCT = load_imanet(path+'data/net_LCT.multi')

#net_LCT.plot_train()


print(net_LCT.test)# print the testing results [loss, accuracy]


net_LCT.plot_cm(gene_sim.classes)





gene_LCT.resize((67,205))
gene_LCT.convert()
gene_LCT.summary()
gene_sim.plot()

model.predict(gene_LCT.data, batch_size=None)






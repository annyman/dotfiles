#ifndef NN_H
#define NN_H

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

struct Layer {
  double *activation;
  double **weights;
  double *biases;
  int num;
  double *cost;
  struct Layer *prev;
};
typedef struct Layer Layer;

static Layer *layer_create(int num_neurons, Layer *prev_layer) {
  Layer *layer = (Layer *)malloc(sizeof(Layer));
  if (!layer)
    return NULL;

  layer->activation = (double *)calloc(num_neurons, sizeof(double));
  if (!layer->activation) {
    free(layer);
    return NULL;
  }

  layer->biases = (double *)malloc(num_neurons * sizeof(double));
  if (!layer->biases) {
    free(layer->activation);
    free(layer);
    return NULL;
  }
  for (int i = 0; i < num_neurons; ++i) {
    layer->biases[i] = ((double)rand() / RAND_MAX * 2.0) - 1.0;
  }

  int prev_num = prev_layer ? prev_layer->num : 0;
  layer->weights = (double **)malloc(num_neurons * sizeof(double *));
  if (!layer->weights) {
    free(layer->biases);
    free(layer->activation);
    free(layer);
    return NULL;
  }

  for (int i = 0; i < num_neurons; ++i) {
    layer->weights[i] = (double *)calloc(prev_num, sizeof(double));
    if (!layer->weights[i]) {
      for (int j = 0; j < i; ++j)
        free(layer->weights[j]);
      free(layer->weights);
      free(layer->biases);
      free(layer->activation);
      free(layer);
      return NULL;
    }
    for (int j = 0; j < prev_num; ++j) {
      layer->weights[i][j] = ((double)rand() / RAND_MAX * 2.0) - 1.0;
    }
  }

  layer->num = num_neurons;

  layer->cost = (double *)malloc(num_neurons * sizeof(double));
  if (!layer->cost) {
    free(layer->activation);
    free(layer);
    return NULL;
  }
  for (int i = 0; i < num_neurons; ++i) {
    layer->cost[i] = 0.0;
  }

  layer->prev = prev_layer;

  return layer;
}

static void layer_free(Layer *layer) {
  if (!layer)
    return;

  if (layer->weights) {
    for (int i = 0; i < layer->num; ++i) {
      free(layer->weights[i]);
    }
    free(layer->weights);
  }

  free(layer->biases);
  free(layer->activation);
  free(layer);
}

typedef struct {
  Layer **layers;
  int num_layers;
  Layer *input;
  Layer *output;
} NeuralNet;

static inline NeuralNet *nn_create(Layer *inp, Layer *out, Layer **layers,
                                   int num_layers) {
  NeuralNet *net = (NeuralNet *)malloc(sizeof(NeuralNet));
  if (!net) {
    printf("Error creating neural network!\nCould not get enough memory "
           "(segfault oopsies)\n");
    return NULL;
  }

  net->input = inp;
  net->output = out;
  net->layers = layers;
  net->num_layers = num_layers;

  return net;
}

static inline void nn_free(NeuralNet *net) { free(net); }

static inline Layer *nn_layer(NeuralNet *net, int i) { return net->layers[i]; }

static inline void forward_prop(NeuralNet *net) {
  Layer *current = net->input;

  for (int l = 0; l < net->num_layers; ++l) {
    Layer *next_layer = net->layers[l];
    for (int i = 0; i < next_layer->num; ++i) {
      next_layer->activation[i] = next_layer->biases[i];
      for (int j = 0; j < current->num; ++j) {
        next_layer->activation[i] +=
            current->activation[j] * next_layer->weights[i][j];
      }
      if (next_layer->activation[i] < 0.0) {
        next_layer->activation[i] = 0.0; // ReLU
      }
    }
    current = next_layer;
  }

  Layer *output = net->output;
  for (int i = 0; i < output->num; ++i) {
    output->activation[i] = output->biases[i];
    for (int j = 0; j < current->num; ++j) {
      output->activation[i] += current->activation[j] * output->weights[i][j];
    }
  }
}

static inline void layer_cost(Layer *layer, double *expected) {
  for (int i = 0; i < layer->num; ++i) {
    layer->cost[i] = layer->activation[i] - expected[i];
  }
}

static inline void back_prop(Layer *layer) {
  // TODO: calculate cost function for each neuron in the given layer
  // layer_cost(current, copy of itself before back propogation)
}

static inline void gradient_descent(NeuralNet *net) {
  // TODO: runs back_prop on each layer until the input layer is reached
  // do not run back_prop on input layer, check if it is hidden layer beforehand
}

#endif

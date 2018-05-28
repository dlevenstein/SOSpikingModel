/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * CAdLIFfunction_STDP_types.h
 *
 * Code generation for function 'CAdLIFfunction_STDP'
 *
 */

#ifndef CADLIFFUNCTION_STDP_TYPES_H
#define CADLIFFUNCTION_STDP_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray_boolean_T
#define struct_emxArray_boolean_T

struct emxArray_boolean_T
{
  boolean_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_boolean_T*/

#ifndef typedef_emxArray_boolean_T
#define typedef_emxArray_boolean_T

typedef struct emxArray_boolean_T emxArray_boolean_T;

#endif                                 /*typedef_emxArray_boolean_T*/

#ifndef struct_emxArray_int32_T
#define struct_emxArray_int32_T

struct emxArray_int32_T
{
  int32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_int32_T*/

#ifndef typedef_emxArray_int32_T
#define typedef_emxArray_int32_T

typedef struct emxArray_int32_T emxArray_int32_T;

#endif                                 /*typedef_emxArray_int32_T*/

#ifndef struct_emxArray_real32_T
#define struct_emxArray_real32_T

struct emxArray_real32_T
{
  real32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real32_T*/

#ifndef typedef_emxArray_real32_T
#define typedef_emxArray_real32_T

typedef struct emxArray_real32_T emxArray_real32_T;

#endif                                 /*typedef_emxArray_real32_T*/

#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef typedef_struct0_T
#define typedef_struct0_T

typedef struct {
  real_T I_e;
  real_T sigma;
  real_T theta;
  real_T EPopNum;
  real_T IPopNum;
  real_T E_L[2];
  real_T g_L[2];
  real_T C[2];
  real_T V_th[2];
  real_T V_reset[2];
  real_T t_ref;
  real_T E_e;
  real_T E_i;
  real_T tau_s[2];
  real_T E_w;
  real_T b_w;
  real_T b;
  real_T delta_T;
  real_T w_r;
  real_T gwnorm;
  real_T Wee;
  real_T Wii;
  real_T Wie;
  real_T Wei;
  real_T Kee;
  real_T Kii;
  real_T Kie;
  real_T Kei;
  real_T LearningRate;
  real_T TargetRate;
  real_T tauSTDP;
} struct0_T;

#endif                                 /*typedef_struct0_T*/

#ifndef typedef_struct1_T
#define typedef_struct1_T

typedef struct {
  real_T dt;
  real_T SimTime;
} struct1_T;

#endif                                 /*typedef_struct1_T*/

#ifndef typedef_struct2_T
#define typedef_struct2_T

typedef struct {
  emxArray_real_T *t;
  emxArray_real_T *V;
  emxArray_real_T *g_w;
  emxArray_real_T *g_e;
  emxArray_real_T *g_i;
  emxArray_real_T *s;
  emxArray_real_T *w;
  emxArray_real_T *a_w;
  emxArray_real_T *Input;
  emxArray_real_T *t_weight;
  emxArray_real_T *WeightMat;
  emxArray_real32_T *spikes;
  emxArray_real_T *EcellIDX;
  emxArray_real_T *IcellIDX;
} struct2_T;

#endif                                 /*typedef_struct2_T*/
#endif

/* End of code generation (CAdLIFfunction_STDP_types.h) */

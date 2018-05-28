/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * CAdLIFfunction_STDP_emxutil.h
 *
 * Code generation for function 'CAdLIFfunction_STDP_emxutil'
 *
 */

#ifndef CADLIFFUNCTION_STDP_EMXUTIL_H
#define CADLIFFUNCTION_STDP_EMXUTIL_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "CAdLIFfunction_STDP_types.h"

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_boolean_T1(emxArray_boolean_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_int32_T1(emxArray_int32_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_int8_T(emxArray_int8_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_real32_T(emxArray_real32_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_real32_T1(emxArray_real32_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_real_T1(emxArray_real_T *emxArray, int32_T
    oldNumel);
  extern void emxEnsureCapacity_real_T2(emxArray_real_T *emxArray, int32_T
    oldNumel);
  extern void emxFreeMatrix_cell_wrap_1(cell_wrap_1 pMatrix[2]);
  extern void emxFreeStruct_struct2_T(struct2_T *pStruct);
  extern void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);
  extern void emxFree_int32_T(emxArray_int32_T **pEmxArray);
  extern void emxFree_int8_T(emxArray_int8_T **pEmxArray);
  extern void emxFree_real32_T(emxArray_real32_T **pEmxArray);
  extern void emxFree_real_T(emxArray_real_T **pEmxArray);
  extern void emxInitMatrix_cell_wrap_1(cell_wrap_1 pMatrix[2], boolean_T doPush);
  extern void emxInitStruct_struct2_T(struct2_T *pStruct, boolean_T doPush);
  extern void emxInit_boolean_T(emxArray_boolean_T **pEmxArray, int32_T
    numDimensions, boolean_T doPush);
  extern void emxInit_boolean_T1(emxArray_boolean_T **pEmxArray, int32_T
    numDimensions, boolean_T doPush);
  extern void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T
    numDimensions, boolean_T doPush);
  extern void emxInit_int32_T1(emxArray_int32_T **pEmxArray, int32_T
    numDimensions, boolean_T doPush);
  extern void emxInit_int8_T(emxArray_int8_T **pEmxArray, int32_T numDimensions,
    boolean_T doPush);
  extern void emxInit_real32_T(emxArray_real32_T **pEmxArray, int32_T
    numDimensions, boolean_T doPush);
  extern void emxInit_real32_T1(emxArray_real32_T **pEmxArray, int32_T
    numDimensions, boolean_T doPush);
  extern void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
    boolean_T doPush);
  extern void emxInit_real_T1(emxArray_real_T **pEmxArray, int32_T numDimensions,
    boolean_T doPush);
  extern void emxInit_real_T2(emxArray_real_T **pEmxArray, int32_T numDimensions,
    boolean_T doPush);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (CAdLIFfunction_STDP_emxutil.h) */

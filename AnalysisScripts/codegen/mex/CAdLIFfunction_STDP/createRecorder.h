/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * createRecorder.h
 *
 * Code generation for function 'createRecorder'
 *
 */

#ifndef CREATERECORDER_H
#define CREATERECORDER_H

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
extern void createRecorder(const emlrtStack *sp, const real_T recordIntervals[4],
  real_T TimeParams_dt, real_T TimeParams_SimTime, emxArray_real_T *recordVALs);

#endif

/* End of code generation (createRecorder.h) */

# Function Routines
This folder contains the function routines for different experiments.

## Running CheckBalance
```CheckBalance( SimValues,PopParams,timewin )```
### Inputs
* `SimValues`: Simulation values that are outputted in any of the RunCodes Functions
    
* `PopParams`: Input parameters that were inserted into a certain RunCodes function

* `timewin`: Window of time to view different figures (in ms).

### Outputs

* `corrhist`:

* `condx`: 

* `currx`: 

* `currPETH`:

## Example: 
    
    ``` [SimValues] = AdLIFfunction_iSTDP(PopParams,TimeParams,varargin)```

    ``` CheckBalance( SimValues,PopParams,timewin ) ```

## Running GetSpikeStats

```GetSpikeStats( SimValues,PopParams,timewin )```

### Inputs

* `SimValues`: Simulation values that are outputted in any of the RunCodes Functions

* `PopParams`: Input parameters that were inserted into a certain RunCodes function

* `timewin`: Window of time to view different figures (in ms).

## Example: 
    
    ``` [SimValues] = AdLIFfunction_iSTDP(PopParams,TimeParams,varargin)```

    ``` GetSpikeStats( SimValues,PopParams,timewin ) ```

## Running SimulateFICurve

```SimValuesArray = SimulateFICurve(PopParams_in,Irange,numI,varargin)```

### Inputs

* `PopParams_in`: Input parameters that were inserted into a certain RunCodes function

* `Irange`: Range of current values in for parameter `I_e` (in pA).

* `numI`: Number of incremental `I_e` values in Irange.

### Outputs

* `SimValuesArray`: Array of simulation values for each `I_e` value.

## Running SimulateFrozenNetwork

```[SimValuesTest,PopParams_in] = SimulateFrozenNetwork(SimValues,PopParams_in)```

### Inputs

* `SimValues`: Simulation values from a RunCodes function.

* `PopParams_in`: Input parameters that were inserted into a certain RunCodes function

### Outputs

* `SimValuesTest`: Simulation values from a RunCodes function.

* `PopParams_in`: Input parameters that were inserted into a certain RunCodes function
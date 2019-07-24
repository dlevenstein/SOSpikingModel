# RunCodes

Each of these function are different models of a leaky integrate and fire neuron with adaptation.

 ## `AdLIFfunction_iSTDP`: 
 Adaptating Leaky Integrate and Fire Neuron with Conductance-based synapses and adaptation, with inhibitory plasticity from inhibitory to excitatory and inhibitory to inhibitory neurons. Solver is forward euler. 

 Neuron Model: Leaky Integrate and Fire

 Synapse Model: Conductance-based with exponential jump to 1

 Plasticity Model: Symmetrical STDP model for Inhibitory to Inhibitory and Inhibitory to Excitatory Neurons

 Solver: Forward Euler
    
| Dynamic State Variables |  |  | 
| --- | --- | --- | 
| `V` | mV | Membrane Potential | 
| `g_e` | nS | Excitatory Conductance | 
| `g_i` | nS | Inhibitory Conductance | 
| `g_w` | nS | Adaptation Conductance | 
| `s` | | Synaptic dynamic variable |
| `x` | | Synaptic Trace | 

| Membrane Parameters |  |  | 
| --- | --- | --- | 
| `C` | pF | Membrane Capacitance | 
| `t_ref` | ms | Refractory Period | 
| `V_reset` | mV | Reset value after spike | 
| `E_L` | mV | Leak reversal potential | 
| `g_L` | nS | Leak conductance | 
| `V_th` | mV | Spiking threshold | 
| `I_e` | pA | External input current | 
| `sigma` | pA | Standard deviation of noise | 
| `theta` | 1/ms | Time filtration of noise |

| Spike Adaptation Parameters |  |  | 
| --- | --- | --- | 
| `gwnorm` | nS | Adaptation weight | 
| `tau_w` | ms | Adaptation decay | 
| `a` |  | Subthreshold adaptation | 

| Plasticity Parameters |  |  | 
| --- | --- | --- | 
| `TargetRateE` | Hz | Excitatory target rate | 
| `TargetRateI` | Hz | Inhibitory target rate | 
| `tauSTDP` | ms | Time constant for STDP curve | 

> Note: change `TargetRateE` or `TargetRateI` to `NaN` to turn off the plasticity in that synaptic connection

| Synaptic Parameters |  |  | 
| --- | --- | --- | 
| `E_e` | mV | Excitatory reversal potential | 
| `E_i` | mV | Inhibitory reversal potential | 
| `tau_s` | ms | Time constant for synapses | 

### Options

`showfig`: Show a figure at the end of the simulation (default: true)

`showprogress`: Show progress of the simulation (default: false)

`onsettime`: The start time of when to start recording (default: 0)

`save_dt`: Time resolution of saved simulation values (default: 0.5)

`save_weights`: Time resolution of saved weight values (default: 10)

`cellout`: sort spike times to each cell (default: false)

`recordInterval`: Times intervals to save simulation values (default: [])

* Example: 

    * `'recordInterval', [10 1000]`

    * Saves only values between 10 to 1000 ms

`useGPU`: Use GPU if available, turns off automatically if no GPU available (default: true)

`train`: Sets simulation to training state (default: false)

* This only saves specific values for the simulation: 

    * `WeightMat`: weights of the network
    
    * `WeightChange`: mean and standard deviation of weights over simulation

    * `spikeRate`: spike rate of the network

`defaultNeuronParams`: Use the defaults parameters of the model (default: true)

| Membrane Parameters |  |  | 
| --- | --- | --- | 
| --- | Exc | Inh | 
| `C` | 182 | 119 | 
| `t_ref` | 0.5 | 0.5 | 
| `V_reset` | -55 | -55 | 
| `E_L` | -65 | -67 | 
| `g_L` | 182/18 | 119/8 | 
| `V_th` | -45 | -47 | 

| Spike Adaptation Parameters |  |  | 
| --- | --- | --- | 
| --- | Exc | Inh | 
| `gwnorm` | 0 |  | 
| `tau_w` | 300 |  | 
| `a` | 0 |  | 

| Synaptic Parameters |  |  | 
| --- | --- | --- | 
| --- | Exc | Inh | 
| `E_e` | 0 |  | 
| `E_i` |  | -80 | 
| `tau_s` | 5 | 5 | 

### Initial Value Options

* `V0`: initial value for voltages `V`

* `w0`: initial value for adaptation `w`

* `s0`: initial value for synapses `s`

## `AdLIFfunction`: 
 Adaptating Leaky Integrate and Fire Neuron with Conductance-based synapses and adaptation. Solver is forward euler. 
    
| Dynamic State Variables |  |  | 
| --- | --- | --- | 
| `V` | mV | Membrane Potential | 
| `g_e` | nS | Excitatory Conductance | 
| `g_i` | nS | Inhibitory Conductance | 
| `g_w` | nS | Adaptation Conductance | 

| Membrane Parameters |  |  | 
| --- | --- | --- | 
| `C` | pF | Membrane Capacitance | 
| `t_ref` | ms | Refractory Period | 
| `V_reset` | mV | Reset value after spike | 
| `E_L` | mV | Leak reversal potential | 
| `g_L` | nS | Leak conductance | 
| `V_th` | mV | Spiking threshold | 
| `I_e` | pA | External input current | 
| `sigma` | pA | Standard deviation of noise | 
| `theta` | 1/ms | Time filtration of noise |

| Spike Adaptation Parameters |  |  | 
| --- | --- | --- | 
| `adapt` | pA | Adaptation magnitude | 
| `tau_a` | ms | Adaptation decay | 

| Synaptic Parameters |  |  | 
| --- | --- | --- | 
| `E_e` | mV | Excitatory reversal potential | 
| `E_i` | mV | Inhibitory reversal potential | 
| `tau_e` | ms | Time constant for excitatory synapses | 
| `tau_i` | ms | Time constant for inhibitory synapses | 
Digging Deeper
==============


Robot Model
~~~~~~~~~~~

We model the robot with the following floating base multi-rigid-body dynamics equation of motion:

.. math::
   :label: eom

   \mathbf{M}(\mathbf{q})\,\dot{\mathbf{v}} + \mathbf{c}(\mathbf{q},\mathbf{v}) + \mathbf{g}(\mathbf{q})
   = \mathbf{S}^T\,\boldsymbol{\tau} + \boldsymbol{\tau}_{\text{ext}}

where 

- **Generalized Position:**  
  :math:`\mathbf{q} = [\mathbf{q}_{\text{b}}^T, \mathbf{q}_{\text{j}}^T]^T \in \mathbb{R}^{n_q}` is the generalized position, consisting of the base pose  
  :math:`\mathbf{q}_{\text{b}} \in \mathbb{R}^7` and joint positions :math:`\mathbf{q}_{\text{j}} \in \mathbb{R}^{n_{\text{j}}}`.

- **Generalized Velocity and Acceleration:**  
  :math:`\mathbf{v},\; \dot{\mathbf{v}} \in \mathbb{R}^{n_q}` are the generalized velocity and acceleration, respectively.

- **Mass Matrix:**  
  :math:`\mathbf{M}(\mathbf{q}): \mathbb{R}^{n_q} \rightarrow \mathbb{R}^{n_q \times n_q}`.

- **Coriolis Force:**  
  :math:`\mathbf{c}(\mathbf{q},\mathbf{v}): \mathbb{R}^{n_q} \times \mathbb{R}^{n_q} \rightarrow \mathbb{R}^{n_q}`.

- **Gravity:**  
  :math:`\mathbf{g}(\mathbf{q}): \mathbb{R}^{n_q} \rightarrow \mathbb{R}^{n_q}`.

- **Selection Matrix:**  
  :math:`\mathbf{S} = \Bigl[\mathbf{0}_{n_\tau \times (n_q - n_\tau)},\; \mathbb{I}_{n_\tau}\Bigr]`.

- **Joint Torque:**  
  :math:`\boldsymbol{\tau} \in \mathbb{R}^{n_\tau}`.

- **External Torque:**  
  :math:`\boldsymbol{\tau}_{\text{ext}}` is defined below.

The external torque is given by

.. math::
   :label: external_torque

   \boldsymbol{\tau}_{\text{ext}} = \mathbf{J}(\mathbf{q})^T\,\mathbf{f}_{\text{ext}}
   = \mathbf{J}(\mathbf{q})^T\,\Bigl[\mathbf{f}_{\text{b}}^T, \mathbf{f}_1^T, \ldots, \mathbf{f}_{n_{\text{c}}}^T\Bigr]^T 

where 

- :math:`\mathbf{f}_{\text{b}},\; \mathbf{f}_i \in \mathbb{R}^{6}` are the base and contact wrenches, and 
- :math:`\mathbf{J}(\mathbf{q}): \mathbb{R}^{n_q} \rightarrow \mathbb{R}^{(n_{\text{c}}+1) \times 6 \times n_q}` is the contact Jacobian.

We also have an actuator model with motor velocity-torque saturation and friction for each joint:

.. math::
   
   \boldsymbol{\tau} = \max\!\Bigl\{\min\!\Bigl\{\tau_{\text{cmd}},\; \underline{\tau}\Bigr\},\; \overline{\tau}\Bigr\} - \tau_{\mu}

Let :math:`q_j` denote the :math:`j` th joint position and :math:`\tau_{\text{cmd}}` the command from the controller. The velocity-dependent torque limits are defined as

- Upper torque limit:  
  :math:`\overline{\tau} = [\overline{\tau}_{1}, \overline{\tau}_{2}, \ldots, \overline{\tau}_{n_{\text{j}}}]^T`

- Lower torque limit:  
  :math:`\underline{\tau} = [\underline{\tau}_{1}, \underline{\tau}_{2}, \ldots, \underline{\tau}_{n_{\text{j}}}]^T`

with

.. math::
   
   \overline{\tau}_j(\dot{q}_j) = \operatorname{clip}\!\left(\tau_{\text{sat},j} \times \Bigl(1 - \frac{\dot{q}_j}{\overline{\dot{q}}_j}\Bigr),\; 0,\; \overline{\tau}_j\right),\quad
   \underline{\tau}_j(\dot{q}_j) = \operatorname{clip}\!\left(\tau_{\text{sat},j} \times \Bigl(-1 - \frac{\dot{q}_j}{\overline{\dot{q}}_j}\Bigr),\; -\overline{\tau}_j,\; 0\right)

Finally, the joint friction maybe modeled as

.. math::
   
   \tau_{\mu,j} = \mu_{\text{v},j}\,\dot{q}_j + \mu_{\text{c}}\,\tanh\!\left(\frac{\dot{q}_j}{\dot{q}_{\text{s},j}}\right),

where :math:`\tau_{\mu} = [\tau_{\mu,1}, \tau_{\mu,2}, \ldots, \tau_{\mu,n_{\text{j}}}]^T`. 

Most of the model parameters are obtained from the URDF file, and by using `pinocchio` we can compute most of the dynamics quantities we need for the below modules.


Generalized Momentum Observer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

External Torque
---------------

As shown in :eq:`external_torque`, external torque is very useful—it can include:

- Base disturbance wrench or payload
- End-effector wrench (contact state)
- Joint friction

From :eq:`eom`, we know that we can obtain external torque from the generalized coordinate, velocity, acceleration, and joint torques. However, note that joint acceleration is twice the derivative of raw sensor data, which is very noisy.

Generalized Momentum
--------------------

Generalized momentum is defined as follows:

.. math::
   
   \mathbf{p} = \mathbf{M}\mathbf{v}.

The derivative of the generalized momentum is

.. math::
   \begin{aligned}
   \dot{\mathbf{p}} &= \dot{\mathbf{M}}\mathbf{v} + \mathbf{M}\dot{\mathbf{v}} \\
                    &= \dot{\mathbf{M}}\mathbf{v} + \mathbf{S}^T\boldsymbol{\tau} + \boldsymbol{\tau}_{\text{ext}} - \mathbf{C}\mathbf{v} - \mathbf{g} \\
                    &= (\mathbf{C} + \mathbf{C}^T)\mathbf{v} + \mathbf{S}^T\boldsymbol{\tau} + \boldsymbol{\tau}_{\text{ext}} - \mathbf{C}\mathbf{v} - \mathbf{g} \\
                    &= \boldsymbol{\tau}_{\text{ext}} + \mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g}.
   \end{aligned}

We can formulate a generalized momentum observer:

- **Input:**
  - Generalized coordinate
  - Generalized velocity
  - Torque of each joint
- **Output:** External torque

Assume a low-pass filter is applied to the external torque:

.. math::
   \begin{aligned}
   \hat{\boldsymbol{\tau}}_{\text{ext}} &= \frac{\lambda}{s+\lambda}\,\boldsymbol{\tau}_{\text{ext}}, \\
   \hat{\boldsymbol{\tau}}_{\text{ext}}\,(s+\lambda) &= \lambda\,\boldsymbol{\tau}_{\text{ext}}, \\
   \dot{\hat{\boldsymbol{\tau}}}_{\text{ext}} &= \lambda\,\Bigl(\boldsymbol{\tau}_{\text{ext}} - \hat{\boldsymbol{\tau}}_{\text{ext}}\Bigr), \\
   \dot{\hat{\boldsymbol{\tau}}}_{\text{ext}} &= \lambda\,\Bigl(\dot{\mathbf{p}} - \bigl(\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g} + \hat{\boldsymbol{\tau}}_{\text{ext}}\bigr)\Bigr).
   \end{aligned}

Integrating the above equation, we have

.. math::
   \begin{aligned}
   \hat{\boldsymbol{\tau}}_{\text{ext}} &= \lambda\,\mathbf{p} - \lambda \int_{0}^{t} \Bigl(\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g} + \hat{\boldsymbol{\tau}}_{\text{ext}}\Bigr)\,dt, \\
   \hat{\boldsymbol{\tau}}_{\text{ext}} &= \lambda\,\mathbf{p} - \frac{\lambda}{s}\Bigl(\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g} + \hat{\boldsymbol{\tau}}_{\text{ext}}\Bigr), \\
   \frac{\lambda+s}{s}\,\hat{\boldsymbol{\tau}}_{\text{ext}} &= \lambda\,\mathbf{p} - \frac{\lambda}{s}\Bigl(\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g}\Bigr), \\
   \hat{\boldsymbol{\tau}}_{\text{ext}} &= \frac{\lambda s}{\lambda+s}\,\mathbf{p} - \frac{\lambda}{\lambda+s}\Bigl(\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g}\Bigr), \\
   \hat{\boldsymbol{\tau}}_{\text{ext}} &= \frac{\lambda s}{\lambda+s}\,\mathbf{p} - \frac{\lambda}{\lambda+s}\Bigl(\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g}\Bigr), \\
   \hat{\boldsymbol{\tau}}_{\text{ext}} &= \frac{\lambda (\lambda+s)}{\lambda+s}\,\mathbf{p} - \frac{\lambda^2}{\lambda+s}\,\mathbf{p} - \frac{\lambda}{\lambda+s}\Bigl(\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g}\Bigr), \\
   \hat{\boldsymbol{\tau}}_{\text{ext}} &= \lambda\,\mathbf{p} - \frac{\lambda}{\lambda+s}\Bigl(\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g} + \lambda\,\mathbf{p}\Bigr).
   \end{aligned}

It turns out that the low-pass filtered external torque :math:`\hat{\boldsymbol{\tau}}_{\text{ext}}` can be implemented by measuring the generalized momentum :math:`\mathbf{p}` and maintaining a low-pass filte: with 
:math:`\mathbf{S}^T\boldsymbol{\tau} + \mathbf{C}^T\mathbf{v} - \mathbf{g} + \lambda\,\mathbf{p}` as input and :math:`\lambda` as the cutoff frequency.

Finally, the external wrench can be estimated by

.. math::
   
   \mathbf{f}_{\text{ext}} = \Bigl(\mathbf{J}(\mathbf{q})^T\Bigr)^\dagger\,\hat{\boldsymbol{\tau}}_{\text{ext}},

where :math:`\Bigl(\mathbf{J}(\mathbf{q})^T\Bigr)^\dagger` is the pseudo-inverse of :math:`\mathbf{J}(\mathbf{q})^T`.


Kalman Filter for Base Position and Linear Velocity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The state of the Kalman filter is

.. math::
   
   \mathbf{x}_k = \begin{bmatrix}
       \mathbf{p}_{\text{b}}^T, & \mathbf{v}_{\text{b}}^T, & \mathbf{p}_{\text{c}}^T
   \end{bmatrix}^T,

where

.. math::
   
   \mathbf{p}_{\text{c}} = \begin{bmatrix}
       \mathbf{p}_{c,1}^T, & \cdots, & \mathbf{p}_{c,n_c}^T
   \end{bmatrix}^T

represents the positions of the foot-end contact points. Without loss of generality, assume that the inertial measurement unit coincides with the body center of mass and that the coordinate systems are aligned.

Given the accelerometer measurement :math:`^{\mathcal{B}}\mathbf{a}` and the body attitude rotation matrix :math:`^{\mathcal{W}}\mathbf{R}_{\mathcal{B}}` provided by the inertial measurement unit, the system input is defined as

.. math::
   
   \mathbf{u}_k = \Bigl[\,^{\mathcal{W}}\mathbf{R}_{\mathcal{B}}\;^{\mathcal{B}}\mathbf{a} + \mathbf{g}\Bigr]^T.

The measurement is defined as

.. math::
   
   \mathbf{y}_k = \begin{bmatrix}
       -\mathbf{r}_{\text{b},\text{c}}^T, & \mathbf{z}_{\text{c}}^T
   \end{bmatrix}^T,

where

.. math::
   
   \mathbf{r}_{\text{b},\text{c}} = \begin{bmatrix}
       \mathbf{r}_{b,c_1}^T, & \cdots, & \mathbf{r}_{b,c_{n_c}}^T
   \end{bmatrix}^T,
   \qquad \text{with} \qquad \mathbf{r}_{b,c_i} = \mathbf{p}_{c_i} - \mathbf{p}_b.
   
The foot-end heights

.. math::
   
   \mathbf{z}_c = \begin{bmatrix}
       z_{c_1}, & \cdots, & z_{c_4}
   \end{bmatrix}^T

can be provided by external perception sensors (e.g., vision or radar). If no perception data is available, :math:`\mathbf{z}_c` can be set to :math:`\mathbf{0}`.

Assuming the contact point positions remain unchanged (i.e. no slippage occurs), the process and measurement models are linear:

.. math::
   \begin{aligned}
   \mathbf{x}_{k+1} &= \mathbf{A}\,\mathbf{x}_k + \mathbf{B}\,\mathbf{u}_k + \mathcal{N}(0,\mathbf{Q}), \\
   \mathbf{y}_k     &= \mathbf{C}\,\mathbf{x}_k + \mathcal{N}(0,\mathbf{R}_k).
   \end{aligned}

The state transition and input matrices are given by

.. math::
   \mathbf{A} =
   \begin{bmatrix}
       \mathbb{I}_3       & \delta t           & \mathbf{0}_{3\times n_c} \\
       \mathbf{0}_{3\times3} & \mathbb{I}_3       & \mathbf{0}_{3\times n_c} \\
       \mathbf{0}_{n_c\times3} & \mathbf{0}_{n_c\times3} & \mathbb{I}_{n_c}
   \end{bmatrix},
   \quad
   \mathbf{B} =
   \begin{bmatrix}
       \frac{1}{2}\,\delta t^2\,\mathbb{I}_3 \\
       \delta t\,\mathbb{I}_3 \\
       \mathbf{0}_{n_c\times3}
   \end{bmatrix}.

The measurement matrix is defined as

.. math::
   \mathbf{C} =
   \begin{bmatrix}
       \mathbb{I}_3 & \mathbf{0}_{3\times3} & -\mathbb{I}_3 & \mathbf{0}_{3\times3} & \cdots & \mathbf{0}_{3\times3} \\
       \vdots     & \vdots              & \vdots       & \ddots         & \ddots & \vdots \\
       \mathbb{I}_3 & \mathbf{0}_{3\times3} & \mathbf{0}_{3\times3} & \mathbf{0}_{3\times3} & \cdots & -\mathbb{I}_3 \\
       \mathbf{0}_{1\times3} & \mathbf{0}_{1\times3} & [0,0,1] & \mathbf{0}_{1\times3} & \cdots & \mathbf{0}_{1\times3} \\
       \vdots     & \vdots              & \vdots       & \ddots         & \ddots & \vdots \\
       \mathbf{0}_{1\times3} & \mathbf{0}_{1\times3} & \mathbf{0}_{1\times3} & \mathbf{0}_{1\times3} & \cdots & [0,0,1]
   \end{bmatrix}.

The process noise covariance matrix is constant:

.. math::
   \mathbf{Q} = \Bigl(\operatorname{blockDiag}\bigl(\mathbf{0}_{3\times3},\; \delta t\,\sigma_{\text{accel}}\,\mathbb{I}_3,\; \delta t\,\boldsymbol{\sigma}_{\dot{p}_c}\,\mathbb{I}\bigr)\Bigr)^2.

Most importantly, the time-varying measurement noise covariance matrix is

.. math::
   \mathbf{R}_k = \Bigl(\operatorname{blockDiag}\bigl(\boldsymbol{\sigma}_{p_c\mathbb{I},\, k},\; \boldsymbol{\sigma}_z\bigr)\Bigr)^2,

where

.. math::
   \boldsymbol{\sigma}_{p_c\mathbb{I}} = \operatorname{blockDiag}\bigl(\sigma_{c_1}\,\mathbb{I}_3,\; \cdots,\; \sigma_{c_{n_c}}\,\mathbb{I}_3\bigr),
   \qquad \text{and} \qquad \sigma_{c_i} = \frac{\sigma_{\text{kine}}}{w_{c,i}},
   
with :math:`\sigma_{\text{kine}}` a constant, and :math:`w_{c,i}` is the weight depending on the contact state, defined as

.. math::
   w_{c,i} =
   \begin{cases}
       1,       & \text{if } i \in \mathcal{C}, \\
       \epsilon, & \text{if } i \notin \mathcal{C},
   \end{cases}
   \qquad \forall\, i \in \{1,\cdots,n_c\},

which can be estimated by thresholding the contact force magnitude from the generalized momentum observer.

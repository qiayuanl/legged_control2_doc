<?xml version='1.0' encoding='UTF-8' standalone='yes' ?>
<tagfile doxygen_version="1.9.8">
  <compound kind="class">
    <name>legged::BaseAngVelObservationTerm</name>
    <filename>classlegged_1_1BaseAngVelObservationTerm.html</filename>
    <base>legged::ObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::BaseLinVelObservationTerm</name>
    <filename>classlegged_1_1BaseLinVelObservationTerm.html</filename>
    <base>legged::ObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::CommandManager</name>
    <filename>classlegged_1_1CommandManager.html</filename>
    <base>ManagerBase&lt; CommandTerm &gt;</base>
  </compound>
  <compound kind="class">
    <name>legged::CommandObservationTerm</name>
    <filename>classlegged_1_1CommandObservationTerm.html</filename>
    <base>legged::ObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::CommandTerm</name>
    <filename>classlegged_1_1CommandTerm.html</filename>
  </compound>
  <compound kind="class">
    <name>legged::JointObservationTerm</name>
    <filename>classlegged_1_1JointObservationTerm.html</filename>
    <base>legged::ObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::JointPositionsObservationTerm</name>
    <filename>classlegged_1_1JointPositionsObservationTerm.html</filename>
    <base>legged::JointObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::JointVelocitiesObservationTerm</name>
    <filename>classlegged_1_1JointVelocitiesObservationTerm.html</filename>
    <base>legged::JointObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::LastActionObservationTerm</name>
    <filename>classlegged_1_1LastActionObservationTerm.html</filename>
    <base>legged::ObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::LocalObservationTerm</name>
    <filename>classlegged_1_1LocalObservationTerm.html</filename>
    <base>legged::ObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::ManagerBase</name>
    <filename>classlegged_1_1ManagerBase.html</filename>
    <templarg>typename TermType</templarg>
  </compound>
  <compound kind="class">
    <name>legged::ObservationManager</name>
    <filename>classlegged_1_1ObservationManager.html</filename>
    <base>ManagerBase&lt; ObservationTerm &gt;</base>
  </compound>
  <compound kind="class">
    <name>legged::ObservationTerm</name>
    <filename>classlegged_1_1ObservationTerm.html</filename>
  </compound>
  <compound kind="class">
    <name>legged::OnnxController</name>
    <filename>classlegged_1_1OnnxController.html</filename>
    <base>legged::RlController</base>
  </compound>
  <compound kind="class">
    <name>legged::OnnxPolicy</name>
    <filename>classlegged_1_1OnnxPolicy.html</filename>
    <base>legged::Policy</base>
  </compound>
  <compound kind="class">
    <name>legged::PhaseObservationTerm</name>
    <filename>classlegged_1_1PhaseObservationTerm.html</filename>
    <base>legged::ObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::Policy</name>
    <filename>classlegged_1_1Policy.html</filename>
  </compound>
  <compound kind="class">
    <name>legged::ProjectedGravityObservationTerm</name>
    <filename>classlegged_1_1ProjectedGravityObservationTerm.html</filename>
    <base>legged::LocalObservationTerm</base>
  </compound>
  <compound kind="class">
    <name>legged::RepeatedTimer</name>
    <filename>classlegged_1_1RepeatedTimer.html</filename>
    <member kind="function">
      <type>void</type>
      <name>reset</name>
      <anchorfile>classlegged_1_1RepeatedTimer.html</anchorfile>
      <anchor>a7c23a34c5d576175ad34e645fc945957</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>startTimer</name>
      <anchorfile>classlegged_1_1RepeatedTimer.html</anchorfile>
      <anchor>ae3419b45c162f8f4a14399bd4caf345f</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>void</type>
      <name>endTimer</name>
      <anchorfile>classlegged_1_1RepeatedTimer.html</anchorfile>
      <anchor>a94c6afb0f8db16ef0641bfcc96ef18d3</anchor>
      <arglist>()</arglist>
    </member>
    <member kind="function">
      <type>int</type>
      <name>getNumTimedIntervals</name>
      <anchorfile>classlegged_1_1RepeatedTimer.html</anchorfile>
      <anchor>a7c4957e1538728db505102d8a937da22</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>scalar_t</type>
      <name>getTotalInMilliseconds</name>
      <anchorfile>classlegged_1_1RepeatedTimer.html</anchorfile>
      <anchor>a7dd8da680df9ee271ae946b10e488857</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>scalar_t</type>
      <name>getMaxIntervalInMilliseconds</name>
      <anchorfile>classlegged_1_1RepeatedTimer.html</anchorfile>
      <anchor>abc2d628e3f4fe01b713b4195bf007513</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>scalar_t</type>
      <name>getLastIntervalInMilliseconds</name>
      <anchorfile>classlegged_1_1RepeatedTimer.html</anchorfile>
      <anchor>ab7195b37185adb8091d07080b3c4ef9b</anchor>
      <arglist>() const</arglist>
    </member>
    <member kind="function">
      <type>scalar_t</type>
      <name>getAverageInMilliseconds</name>
      <anchorfile>classlegged_1_1RepeatedTimer.html</anchorfile>
      <anchor>a222da34d5dc6efa9bb0db96b8268afd2</anchor>
      <arglist>() const</arglist>
    </member>
  </compound>
  <compound kind="class">
    <name>legged::RlController</name>
    <filename>classlegged_1_1RlController.html</filename>
  </compound>
  <compound kind="class">
    <name>legged::VelocityTopicCommandTerm</name>
    <filename>classlegged_1_1VelocityTopicCommandTerm.html</filename>
    <base>legged::CommandTerm</base>
  </compound>
</tagfile>

# LinearWorkFlow

`LinearWorkFlow` is a basic state machine for managing state change through a
single linear set of states. That is, there is only one valid sequence of states
and the work flow is either forward or backward through those steps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'linear_work_flow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install linear_work_flow

## Usage

### Define a new work flow

To create a new linear work flow, create a new class that inherits from
`LinearWorkFlow::WorkFlow` with a class method `states` that defines the series
of steps as an array, in the order the states are to be traversed.

```ruby
class WorkFlow < LinearWorkFlow::WorkFlow

  def self.states
    [:one, :two, :three, :four]
  end

end
```

### Use the work flow

A new instance of `WorkFlow` will be created via `new` and will have its state
set as the first state as defined in `WorkFlow.states`.

```ruby
work_flow = WorkFlow.new
work_flow.state == :one
```

### Changing state

Use the methods `forward!` and `back!` to change state.

```ruby
work_flow.forward!
work_flow.state == :two

work_flow.forward!
work_flow.state == :three

work_flow.back!
work_flow.state == :two
```

### Check first and last

`first?` and `last?` methods can be used to check if the work flow is at the beginning or
end of the defined states.

```ruby
work_flow = WorkFlow.new
work_flow.first? == true
work_flow.last? == false
```

### Check permissible states

At any intermediate state the state can go back, go forward, or remain the same.
The `permissible_states` method returns the states that match these actions.

If the state is at the first state there cannot be a back transition, so in
this case `permissible_states` returns the current state and the go forward state.
Similarly, as the state cannot go forward from the last state, `permissible_states`
returns the go back state and the current state when the last state is the
current state.

```ruby
work_flow = WorkFlow.new
work_flow.state == :one
work_flow.permissible_states == [:one, :two]
work_flow.forward!
work_flow.state == :two
work_flow.permissible_states == [:one, :two, :three]
work_flow.forward!
work_flow.state == :three
work_flow.permissible_states == [:two, :three, :four]
work_flow.forward!
work_flow.state == :four
work_flow.permissible_states == [:three, :four]
```

### Initiate at a particular state

A work flow can be initiate at a particular state.

```ruby
last_state = WorkFlow.states.last
work_flow = WorkFlow.at last_state
work_flow.state == last_state == :four
work_flow.last? == true
```

### Check whether a state can be changed

Use the `can?` method to check whether a work flow can be move forward or back.

```ruby
work_flow = WorkFlow.new
work_flow.can?(:back) == false
work_flow.can?(:forward) == true

work_flow.forward!
work_flow.can?(:back) == true
```


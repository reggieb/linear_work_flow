module LinearWorkFlow
  class WorkFlow

    def self.states
      [
        :first,
        :last
      ]
    end

    attr_accessor :index

    def initialize(state=nil)
      self.index = state ? states.index(state) : 0
      raise(InvalidStateError, "State must be in: #{states.inspect}") unless self.index
    end
    class << self
      alias_method :at, :new
    end

    def state
      states[index]
    end

    def forward!
      raise(ChangeStateError, "Cannot go forward from last state") if last?
      self.index += 1
    end

    def back!
      raise(ChangeStateError, "Cannot go back from first state") if first?
      self.index -= 1
    end

    def last?
      state == states.last
    end

    def first?
      index == 0
    end

    def can?(action)
      !!restore_after do
        begin
          send(actions[action])
        rescue ChangeStateError
          false
        end
      end
    end

    def actions
      {
        forward: :forward!,
        back: :back!
      }
    end

    def states
      self.class.states
    end

    def restore_after
      starting_index = index
      result = yield
      self.index = starting_index
      result
    end
  end
end

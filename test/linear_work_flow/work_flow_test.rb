require 'test_helper'
module LinearWorkFlow
  class WorkFlowTest < Minitest::Test

    def test_assumptions
      assert states.length > 1, "These tests assume there are at least two states"
    end

    def test_new
      assert_equal states.first, work_flow.state
    end

    def test_new_with_valid_state
      work_flow valid_state
      assert_equal valid_state, work_flow.state
    end

    def test_new_with_invalid_state
      assert_raises InvalidStateError do
        work_flow :invalid
      end
    end

    def test_forward
      assert_equal states[1], work_flow.forward!
      assert_equal states[1], work_flow.state
    end

    def test_forward_when_state_last
      work_flow states.last
      assert_raises ChangeStateError do
        work_flow.forward!
      end
    end

    def test_back
      work_flow states.last
      assert_equal states[-2], work_flow.back!
      assert_equal states[-2], work_flow.state
    end

    def test_back_when_state_first
      assert_raises ChangeStateError do
        work_flow.back!
      end
    end

    def test_last
      assert_equal false, work_flow.last?
    end

    def test_last_when_state_is_last
      work_flow states.last
      assert_equal true, work_flow.last?
    end

    def test_first
      work_flow states.last
      assert_equal false, work_flow.first?
    end

    def test_first_when_state_is_first
      assert_equal true, work_flow.first?
    end

    def test_can
      assert_equal true, work_flow.can?(:forward)
    end

    def test_can_when_cannot_back
      assert_equal false, work_flow.can?(:back)
    end

    def test_can_when_cannot_forward
      work_flow states.last
      assert_equal false, work_flow.can?(:forward)
    end

    def test_can_when_can_back
      work_flow states.last
      assert_equal true, work_flow.can?(:back)
    end

    def test_at
      work_flow = TempWorkFlow.at valid_state
      assert_equal valid_state, work_flow.state
    end

    def test_forward_state
      assert_equal states[1], work_flow.forward_state
    end

    def test_forward_state_when_last
      work_flow states.last
      assert_equal nil, work_flow.forward_state
    end

    def test_back_state
      work_flow states[1]
      assert_equal states[0], work_flow.back_state
    end

    def test_bach_state_when_first
      assert_equal nil, work_flow.back_state
    end

    def test_permissible_states
      work_flow states[1]
      assert_equal [0, 1, 2].collect{|n| states[n]}, work_flow.permissible_states
    end

    def test_permissible_states_when_first
      assert_equal [0, 1].collect{|n| states[n]}, work_flow.permissible_states
    end

    def test_permissible_states_when_last
      work_flow states.last
      assert_equal [-2, -1].collect{|n| states[n]}, work_flow.permissible_states
    end

    class TempWorkFlow < WorkFlow
      def self.states
        [:one, :two, :three, :four]
      end
    end

    def work_flow(state = nil)
      @work_flow ||= TempWorkFlow.new(state)
    end

    def states
      TempWorkFlow.states
    end

    def valid_state
      @valid_state ||= states.last
    end
  end
end
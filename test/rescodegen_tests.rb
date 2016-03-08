require 'test_helper'

class RescodegenTest < Minitest::Test
    
    def test_that_it_has_a_version_number
        refute_nil ::Rescodegen::VERSION
    end

    def test_version
        assert_equal ::Rescodegen::VERSION, "0.2.0"
    end
end

require 'rails_helper'

# Test suite for the Taco model
RSpec.describe Taco, type: :model do
  # Validation tests
  # ensure column meat present before saving
  it { should validate_presence_of(:meat) }
end
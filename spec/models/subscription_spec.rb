require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:status) }
  it { should have_many(:customers) }
  it { should have_many(:teas) }
end
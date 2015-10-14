require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it{ is_expected.to have_and_belong_to_many(:hospitals) }
  it { is_expected.to have_fields(:name, :hosp, :phone, :address, :coUrl, :bUrl) }
  it { is_expected.to have_field(:div).with_alias(:division) }
  it { is_expected.to have_field(:exp).with_alias(:experience) }
  it { is_expected.to have_field(:spe).with_alias(:specialty) }
end


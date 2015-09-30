class Hospital
  include Mongoid::Document

  field :name, type: String
  field :phone, type: String
  field :address, type: String
  field :grade, type: String
  field :assess, type: String
  field :cHours, as: :clinic_hours, type: String
  field :divs, as: :divisions, type: Array
  field :ss, as: :services, type: Array
  field :url, type: String

  has_and_belongs_to_many :doctors, index: true
end

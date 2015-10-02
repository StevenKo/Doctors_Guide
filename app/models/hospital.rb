class Hospital
  include Mongoid::Document

  field :code, type: String
  field :name, type: String
  field :phone, type: String
  field :address, type: String
  field :grade, type: String
  field :ss, as: :services, type: Array
  field :divs, as: :divisions, type: Array
  field :cHours, as: :clinic_hours, type: Hash

  field :url, type: String
  field :assess, type: String


  has_and_belongs_to_many :doctors, index: true
end

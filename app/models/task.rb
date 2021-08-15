class Task < ApplicationRecord
  # before_validation :set_nameless_name
  
  belongs_to :user
  
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  
  validate :validate_name_not_including_comma
  
  scope :recent, -> { order(created_at: :desc) }
  
  # ransackの検索条件を絞る(カラム)
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end 
  
  # ransackの検索条件を絞る(関連)
  def self.ransackable_associations(auth_object = nil)
    []
  end 
  
  private
  
  #def set_nameless_name
  #  self.name = "名前なし" if name.blank?
  #end 
  
  def validate_name_not_including_comma
    errors.add(:name, "にカンマを含めることはできません") if name&.include?(",")
  end
end

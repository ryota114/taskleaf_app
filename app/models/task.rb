class Task < ApplicationRecord
  # before_validation :set_nameless_name
  
  has_one_attached :image
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
  
  # タスクをCSV出力する、どの属性をどの順番で出力するかcsv_attrubutesというメソッドで取得
  def self.csv_attributes
    ["name", "description", "created_at", "updated_at"]
  end 
  
  # タスクをCSV出力する、生成
  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr)}
      end 
    end 
  end 
  
  private
  
  #def set_nameless_name
  #  self.name = "名前なし" if name.blank?
  #end 
  
  def validate_name_not_including_comma
    errors.add(:name, "にカンマを含めることはできません") if name&.include?(",")
  end
end

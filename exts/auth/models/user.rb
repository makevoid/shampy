class User
  include DataMapper::Resource

  ROLES = [ :guest, :member, :admin ]


  property :id,         Serial
  property :username,   String, length: 100, required: true, unique: true
  property :role,       Enum[*ROLES], default: :guest
  property :password,   String, required: true, length: 5..50
  property :salt,       String
  #property :avatar,     String, length: 255
  #property :signature,  Text

  #has n, :posts

  default_scope(:default).update order: :id.desc

  ROLES.each do |role|
    define_method "#{role}?" do
      self.role == role
    end
  end

  # require "#{PATH}/lib/forum_user"
  # include ForumUser

  # authentication

  require 'digest/sha2'

  attr_accessor :password_confirmation

  validates_confirmation_of :password


  before :create do
    generate_salt
    self.password = crypt_password self.password
  end

  def password?(pass)
    self.password == crypt_password(pass)
  end

  def crypt_password(pass)
    hexdigest "#{self.salt}comesefosse#{pass}"
  end

  def generate_salt
    self.salt = hexdigest "#{Time.now}sblinda"
  end

  def hexdigest(string)
    Digest::SHA2.hexdigest(string)[0..49]
  end

end
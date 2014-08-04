class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains
	validates :name, presence: true, uniqueness: true
  has_secure_password

  private
    def ensure_an_admin_remains
      if User.count.zero?
        # causes an automatic rollback as it is raised in a transaction
        raise "Can't delete last user"
      end
    end
end

require 'user_stamp'
require 'migration_helper'

class ActionController::Base
  extend UserStamp::ClassMethods
end

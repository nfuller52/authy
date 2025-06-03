# frozen_string_literal: true

# <-- has the data types defined
class UserSerializer
  %w[id first_name last_name birthdate created_at updated_at] # <-- on the way OUT these fields are the only ones rendered. social security is excluded
end

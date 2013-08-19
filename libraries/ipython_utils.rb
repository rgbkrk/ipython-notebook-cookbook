#!ruby19
# encoding: utf-8

require 'digest'
require 'securerandom'

module IPythonAuth
   def IPythonAuth.ipython_hash(password)

      hash_alg = Digest::SHA512
      hash_name = 'sha512'

      salt = SecureRandom.hex(6)
      password_hash = hash_alg.hexdigest(password + salt)
      return [hash_name, salt, password_hash].join(":")
   end
end


class PlaidInstitution < ApplicationRecord
  acts_as_universal

  def self.refresh!
    batch_size = 500
    offset = 0
    count = 0
    client = PlaidWrapper.client

    loop do
      institutions = client.institutions.get(count: batch_size, offset: offset)

      count = institutions['total'] unless offset > 0

      institutions['institutions'].each do |hash|
        pi = PlaidInstitution.find_or_initialize_by name: hash['name'], plaid_id: hash['institution_id']

        if pi.new_record?
          pi.json = hash
          pi.save!
        end
      end

      count = count - batch_size
      offset = offset + batch_size

      break if count <= 0
    end
  end
end

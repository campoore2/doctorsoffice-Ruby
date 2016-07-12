require("rspec")
require("pg")
require("patient")
require("doctor")

DB = PG.connect({:dbname => 'test_doctors'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM Doctors *;")
    DB.exec("DELETE FROM patients *;")
  end
end

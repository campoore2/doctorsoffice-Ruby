class Patient

  attr_reader(:name, :dob, :doctor_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @dob = attributes.fetch(:dob)
    @doctor_id = attributes.fetch(:doctor_id)
    @id = attributes[:id] || nil
  end

  define_method(:==) do |another_patient|
    self.name() == another_patient.name() & self.dob() == another_patient.dob & self.doctor_id() == another_patient.doctor_id()
  end

  define_singleton_method(:all) do
    returned_patient = DB.exec('SELECT * FROM patients;')
    patients = []
    returned_patient.each() do |patient|
      name = patient.fetch("name")
      dob = patient.fetch("dob")
      doctor_id = patient.fetch("doctor_id").to_()
      patients.push(Patient.new({:name => name, :dob => dob, :doctor_id => doctor_id}))
    end
    patients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patient(name, dob, doctor_id) VALUES ('#{name}', '#{dob}', '#{doctor_id}') RETURNING id;")
    @id = result.first.fetch('id').to_i()
  end

  define_singleton_method(:delete) do |id|
    DB.exec("DELETE FROM patients WHERE id = #{id}")
  end
end

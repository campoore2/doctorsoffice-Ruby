class Doctor
  attr_reader(:name, :spec, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @spec = attributes.fetch(:spec)
    @id = attributes[:id] || nil
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec('SELECT * FROM doctors ORDER BY name;')
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch('name')
      spec = doctor.fetch('spec')
      id = doctor.fetch('id').to_i
      doctors.push(Doctor.new({:name => name, :spec => spec, :id => id}))
    end
    doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, spec) VALUES ('#{@name}', '#{@spec}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_singleton_method(:find) do |identification|
    Doctors.all().each() do |doctor|
      if doctors.id == identification
        return doctors
      end
    end
  end

  define_singleton_method(:delete) do |id|
    DB.exec("DELETE FROM doctors WHERE id = #{id}")
  end
  
  define_method(:==) do |another_doctor|
    (self.name() == another_doctor.name()).&(self.id() == another_doctor.id())
  end
end

require('spec_helper')
require('pry')

describe(Patient) do
  describe("#==") do
    it("compares two patients") do
      patient1 = Patient.new({:name => 'Matt', :dob => '4/3/1911', :doctor_id => 1 })
      patient2 = Patient.new({:name => 'Matt', :dob => '4/3/1911', :doctor_id => 1 })
      expect(patient1).to(eq(patient2))
    end
  end

  describe(".all") do
    it("starts off with no patients") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves a patient in to the patient table") do
      patient1 = Patient.new({:name => 'Matt', :dob => '1911-04-03', :doctor_id => 1 })
      patient1.save()
      expect(Patient.all()).to(eq([patient1]))
    end
  end

  describe(".delete") do
    it("deletes a patient that in the table") do
      patient1 = Patient.new({:name => 'Matt', :dob => '1911-04-03', :doctor_id => 1 })
      patient1.save()
      Patient.delete(patient1.id())
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#id') do
    it('sets its ID when you save it') do
      patient = Patient.new({:name => 'Matt', :dob => '1911-04-03', :doctor_id => 1 })
      patient.save()
      expect(patient.id()).to(be_an_instance_of(Fixnum))
    end
  end
end

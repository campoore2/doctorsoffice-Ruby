require('spec_helper')

describe("doctor") do
  describe(".all") do
    it("starts out with an empty database so all returns nill") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves a value in the doctor table") do
      test_doctor = Doctor.new({:name => "matt", :spec => "none"})
      test_doctor.save()
      expect(Doctor.all()).to(eq([test_doctor]))
    end
  end

  describe("#delete") do
    it ('will remove a doctor from the database') do
      test_doctor = Doctor.new({:name => "matt", :spec => "none"})
      test_doctor.save()
      Doctor.delete(test_doctor.id())
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#==") do
    it('will return two lists of the same name') do
      test_doctor = Doctor.new({:name => "matt", :spec => "none"})
      test_doctor2 = Doctor.new({:name => "matt", :spec => "none"})
      expect(test_doctor).to(eq(test_doctor2))
    end
  end
end

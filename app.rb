require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => "doctors"})

get('/') do
  erb(:index)
end

get('/add') do
  @doctors = Doctor.all()
  erb(:add)
end

get('/add/doctor') do
  erb(:add_dr)
end

post('/add/doctor') do
  name = params.fetch('doctor_name')
  spec = params.fetch('doctor_spec')
  dr = Doctor.new({:name => name, :spec => spec})
  dr.save()
  @doctors = Doctor.all()
  erb(:add)
end

get('/add/patient_doctor') do
  @doctors = Doctor.all()
  erb(:add_patient_doctor)
end

get('/add/patient_doctor/:id/patient_info') do
  @doctor_id = params.fetch('id').to_i()
  erb(:add_patient_info)
end

post('/add') do
  patient_name = params.fetch('patient_name')
  dob = params.fetch('patient_dob')
  doctor_id = params.fetch('doctor').to_i()
  patient = Patient.new({:name => patient_name, :dob => dob, :doctor_id => doctor_id})
  patient.save()
  @doctors = Doctor.all()
  erb(:add)
end

get('/doctor') do
  @doctors = Doctor.all()
  erb(:doctor)
end

get('/doctor/:id/patients') do
  @doctor = params.fetch('id').to_i()
  @patients = Patient.find_doctor_id(@doctor)
  erb(:patients)
end

get('/doctors/:id/patients/:patient_id/patient_info') do
  patient_id = params.fetch('patient_id').to_i
  patient = Patient.find(patient_id)
  @dob = patient.dob()
  @name = patient.name()
  erb(:patient_info)
end

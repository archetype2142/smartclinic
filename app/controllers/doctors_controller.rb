class DoctorsController < ApplicationController
  helper_method :doctors, :doctor

  def index; end

  def show; end
  
  def create
  	Doctor.create!(doctor_params) unless Doctor.all.where(name: doctor_params[:name]).any?
  end

  def delete
  	Doctor.find(doctor_params[:id]).destroy!
  end

private
  
  def doctors
  	doctors ||= Doctor.preload(:specializations)
  end

  def doctor
  	doctor ||= Doctor.find(doctor_params[:id])
  end

  def doctor_params
  	params.permit(:id, :name, :booksy_url, :lek_url, :specialization)
  end
end
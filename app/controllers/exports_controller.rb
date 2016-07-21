class ExportsController < ApplicationController

  def index
  end

  def events
    flash[:notice] = "Processing events export. Results will be emailed to you."
    GenerateExportJob.perform_later("events", current_user)
    render action: "index"
  end

  def events_demographics
    flash[:notice] = "Processing event demographics export. Results will be emailed to you."
    GenerateExportJob.perform_later("events_demographics", current_user)
    render action: "index"
  end

  def events_feedback
    flash[:notice] = "Processing event feedback export. Results will be emailed to you."
    GenerateExportJob.perform_later("events_feedback", current_user)
    render action: "index"
  end


  def members
    flash[:notice] = "Processing members export. Results will be emailed to you."
    GenerateExportJob.perform_later("members", current_user)
    render action: "index"
  end


  def projects
    flash[:notice] = "Processing projects export. Results will be emailed to you."
    GenerateExportJob.perform_later("projects", current_user)
    render action: "index"
  end


  def questionnaire
    if params[:followup]
      flash[:notice] = "Processing followup questionnaire export. Results will be emailed to you."
      GenerateExportJob.perform_later("followup_questionnaire", current_user)
      render action: "index"
    else
      flash[:notice] = "Processing initial questionnaire export. Results will be emailed to you."
      GenerateExportJob.perform_later("initial_questionnaire", current_user)
      render action: "index"
    end
  end

end

class ExportsController < ApplicationController

  def index
  end

  def events
    flash[:info] = "Processing events export. Results will be emailed to you."
    GenerateExportJob.perform_later("events", current_user)
    redirect_to action: "index"
  end

  def events_demographics
    flash[:info] = "Processing event demographics export. Results will be emailed to you."
    GenerateExportJob.perform_later("events_demographics", current_user)
    redirect_to action: "index"
  end

  def events_feedback
    flash[:info] = "Processing event feedback export. Results will be emailed to you."
    GenerateExportJob.perform_later("events_feedback", current_user)
    redirect_to action: "index"
  end


  def members
    flash[:info] = "Processing members export. Results will be emailed to you."
    GenerateExportJob.perform_later("members", current_user)
    redirect_to action: "index"
  end


  def projects
    flash[:info] = "Processing projects export. Results will be emailed to you."
    GenerateExportJob.perform_later("projects", current_user)
    redirect_to action: "index"
  end


  def questionnaire
    if params[:followup]
      flash[:info] = "Processing followup questionnaire export. Results will be emailed to you."
      GenerateExportJob.perform_later("followup_questionnaire", current_user)
      redirect_to action: "index"
    else
      flash[:info] = "Processing initial questionnaire export. Results will be emailed to you."
      GenerateExportJob.perform_later("initial_questionnaire", current_user)
      redirect_to action: "index"
    end
  end

end

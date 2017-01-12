class MembersController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_member, only: [:show, :edit, :update, :destroy, :card]

  # GET /members
  def index
    members_scope = Member.all
    unless !params[:filter_region] && !params[:filter]
      members_scope = members_scope.filter_region(params[:filter_region]) unless (params[:filter_region]) == ""
      members_scope = members_scope.like(params[:filter]) if params[:filter]
    end
    @members = smart_listing_create(:members, members_scope, partial: "members/list")
  end

  def cards
    require 'rqrcode'
    # Keep per_page a multiple of 4 for neater printing
    @members = smart_listing_create(:members, Member.all, partial: "members/card_list")
  end

  # GET /members/1
  def show
    @question_sets = QuestionSet.all
  end

  def card
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
    # All the questions that the user needs to answer initially
    #@questions = QuestionSet.first.questions
  end

  def geodata
    # Array this for when we add in lat/lng later
    @geodata = Member.all.map { |m| [m.current_postcode] }
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"member-postcodes\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to @member, notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_params
      params.require(:member).permit( :first_name,
                                      :last_name,
                                      :dob,
                                      :region,
                                      :tel,
                                      :mob,
                                      :email,
                                      :is_resident,
                                      :ethnic_background,
                                      :ethnic_background_other,
                                      :notes,
                                      question_responses_attributes: [
                                        :id,
                                        :question,
                                        :responder,
                                        :subject,
                                        :_destroy
                                      ],
                                      member_locations_attributes: [
                                        :id,
                                        :_destroy,
                                        :member_id,
                                        :location_id,
                                        :from,
                                        :to,
                                        location_attributes: [
                                          :id,
                                          :_destroy,
                                          :name,
                                          :line1,
                                          :line2,
                                          :city,
                                          :postcode
                                        ],
                                      ]
                                    )
    end
end

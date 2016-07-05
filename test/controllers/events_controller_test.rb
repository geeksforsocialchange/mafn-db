require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = create(:event)
    @future_event = create(:event, finish: 1.week.from_now)
    @past_event = create(:event, finish: 1.week.ago)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
    assert_select "th", "Name"
    assert_select "th", "Start"
    assert_select "th", "Location"
    assert_select "th", "Category"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: {  name: @event.name,
                              start: @event.start,
                              finish: @event.finish,
                              location: @event.location,
                              description: @event.description,
                              latitude: @event.latitude,
                              longitude: @event.longitude,
                              type: @event.type,
                              type_other: @event.type_other,
                              category: @event.category,
                              google_id: @event.google_id
                           }
    end
    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
    assert_select ".event__name"
    assert_select ".event__date"
    assert_select ".event__location"
    assert_select ".event__description"
    assert_select ".event__type"
    assert_select ".event__type-other"
    assert_select ".event__category"
    assert_select ".event__google-id"
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "if event starts in the future" do
    get :edit, id: @future_event
    assert_select ".event__error--in-future"
    assert_select "textarea", false
  end

  test "should update event" do
    patch :update, id: @event, event: {   start: @event.start,
                                          finish: @event.finish,
                                          description: @event.description,
                                          latitude: @event.latitude,
                                          longitude: @event.longitude,
                                          name: @event.name,
                                          type: @event.type,
                                          type_other: @event.type_other,
                                          category: @event.category,
                                          location: @event.location }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end

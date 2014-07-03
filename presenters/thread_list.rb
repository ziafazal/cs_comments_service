require_relative 'thread'
require_relative 'thread_utils'

class ThreadListPresenter

  def initialize(threads, user, course_id)
    read_states = ThreadUtils.get_read_states(threads, user, course_id)
    @presenters = threads.map do |thread|
      thread_key = thread._id.to_s
      is_read, unread_count = read_states.fetch(thread_key, [false, thread.comment_count])
      ThreadPresenter.new(thread, user, is_read, unread_count)
    end
  end

  def to_hash
    @presenters.map { |p| p.to_hash }
  end

end

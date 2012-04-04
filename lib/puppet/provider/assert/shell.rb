Puppet::Type.type(:assert).provide(:shell) do

  has_feature :executable

  def exists?
    true
  end

  def success?(exitcode,assertion)
    result = exitcode == resource[:exitcode].to_i
    case assertion
    when :success
      return result
    when :fail
      return !result
    end
  end

  def succeed
    run(:succeed)
  end

  def fail
    run(:fail)
  end

  def run(assertion)

    begin
      output = execute(resource[:command],:failonfail => false, :combine => true).chomp
      exitcode = $CHILD_STATUS.dup

      if resource[:message] == :default
        success_message = "Assertion '#{resource[:name]}' passed"
      else
        succes_message = resource[:message]
      end

      if resource[:fail_message] == :default
        fail_message = "Assertion '#{resource[:name]}' failed"
      else
        fail_message = resource[:fail_message]
      end

      if success?(exitcode,assertion)
        # Success
        message = success_message
        action = resource[:action]
      else
        # Fails
        message = fail_message
        action = resource[:fail_action]
      end

      log = false
      log = true if resource[:logoutput].to_sym == :true
      log = true if resource[:logoutput].to_sym == :onsuccess and not success?(exitcode,assertion)
      log = true if resource[:logoutput].to_sym == :onfailure and not success?(exitcode,assertion)

      if log
          message = [ message , output].join("\n")
      end
    end

    Puppet.send(action,message)
  rescue Exception => detail
    raise Puppet::Error, detail
  end
end

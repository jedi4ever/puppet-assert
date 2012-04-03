Puppet::Type.newtype(:assert) do

  desc <<-EOT
    Run a assertion on the server
    Example:
  EOT

  feature :executable, "The provider can execute command",
    :methods => [:succeed,:fail]

  ensurable do
    defaultto :succeed
    newvalue(:succeed, :event => :assert_succeed) do
      provider.succeed
    end

    newvalue(:fail, :event => :assert_fail) do
      provider.fail
    end
  end

  newparam(:name, :name => true) do
    desc 'arbitrary name used as identity'
  end

  newparam(:command) do
    desc 'Command to execute'
  end

  newparam(:exitcode) do
    desc 'Exitcode to expect'
    defaultto 0
  end

  newparam(:action) do
    desc 'Puppet action to do when assertion succeeds'
    newvalues(:alert,:crit,:debug, :emerg, :err, :info, :notice, :warning, :fail)
    defaultto :notice
  end

  newparam(:message) do
    desc 'Message to display on success'
    defaultto :default
  end

  newparam(:fail_message) do
    desc 'Message to display on failure'
    defaultto :default
  end

  newparam(:logoutput) do
    desc 'Output the result of the command'
    newvalues(:true, :false, :onfailure , :onsuccess)
    defaultto :onfailure
  end

  newparam(:fail_action) do
    desc 'Puppet action to do when assertion fails'
    newvalues(:alert,:crit,:debug, :emerg, :err, :info, :notice, :warning, :fail)
    defaultto :fail
  end

end

param sites_hello_az400_name string = 'hello-az400'
param serverfarms_ASP_az400free_8234_externalid string = '/subscriptions/4cdfb42a-eb88-4fc9-9010-7f4db0143b77/resourceGroups/az400-free/providers/Microsoft.Web/serverfarms/ASP-az400free-8234'
param location string = 'Brazil South'

resource sites_hello_az400_name_resource 'Microsoft.Web/sites@2024-04-01' = {
  name: sites_hello_az400_name
  location: location
  kind: 'functionapp,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_hello_az400_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_hello_az400_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_az400free_8234_externalid
    reserved: true
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'Python|3.11'
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    ipMode: 'IPv4'
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: 'AAA20E737D17DF1CBA7333F4041C380D1EA13F77CD07193F5DD2D0D780DCE982'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    endToEndEncryptionEnabled: false
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_hello_az400_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: sites_hello_az400_name_resource
  name: 'ftp'
  location: location
  properties: {
    allow: false
  }
}

resource sites_hello_az400_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: sites_hello_az400_name_resource
  name: 'scm'
  location: location
  properties: {
    allow: false
  }
}

resource sites_hello_az400_name_web 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: sites_hello_az400_name_resource
  name: 'web'
  location: location
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'Python|3.11'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2022'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: 'REDACTED'
    scmType: 'VSTSRM'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    cors: {
      allowedOrigins: [
        'https://portal.azure.com'
      ]
      supportCredentials: false
    }
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_hello_az400_name_hello 'Microsoft.Web/sites/functions@2024-04-01' = {
  parent: sites_hello_az400_name_resource
  name: 'hello'
  location: location
  properties: {
    script_href: 'https://hello-az400.azurewebsites.net/admin/vfs/home/site/wwwroot/function_app.py'
    test_data_href: 'https://hello-az400.azurewebsites.net/admin/vfs/tmp/FunctionsData/hello.dat'
    href: 'https://hello-az400.azurewebsites.net/admin/functions/hello'
    config: {
      name: 'hello'
      entryPoint: 'hello'
      scriptFile: 'function_app.py'
      language: 'python'
      functionDirectory: '/home/site/wwwroot'
      bindings: [
        {
          direction: 'IN'
          type: 'httpTrigger'
          name: 'req'
          authLevel: 'ANONYMOUS'
          route: 'hello'
        }
        {
          direction: 'OUT'
          type: 'http'
          name: '$return'
        }
      ]
    }
    invoke_url_template: 'https://hello-az400.azurewebsites.net/api/hello'
    language: 'python'
    isDisabled: false
  }
}

resource sites_hello_az400_name_sites_hello_az400_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2024-04-01' = {
  parent: sites_hello_az400_name_resource
  name: '${sites_hello_az400_name}.azurewebsites.net'
  location: location
  properties: {
    siteName: 'hello-az400'
    hostNameType: 'Verified'
  }
}


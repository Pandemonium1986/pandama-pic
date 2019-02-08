/**
##############
## Security ##
##############
Configure security for nexus 3.
*/

// -- Main

/**
// disable anonymous access
security.setAnonymousAccess(true)
log.info('Anonymous access disabled')
*/

//----------------------
// Create new admin user
//----------------------
def adminRole = ['nx-admin']
def pandemonium = security.addUser('michael.maffait', 'Michael', 'Maffait', 'mma@example.com', true, 'changMe123', adminRole)
log.info('User michael.maffait created')

//----------------------
// Create a new role that allows a user same access as anonymous and adds healtchcheck access
//----------------------
def devPrivileges = ['nx-healthcheck-read', 'nx-healthcheck-summary-read']
def anoRole = ['nx-anonymous']
// add roles that uses the built in nx-anonymous role as a basis and adds more privileges
security.addRole('developer', 'Developer', 'User with privileges to allow read access to repo content and healtcheck', devPrivileges, anoRole)
log.info('Role developer created')

//----------------------
// Create new role that allows deployment and create a user to be used on a CI server
//----------------------
// privileges with pattern * to allow any format, browse and read are already part of nx-anonymous
def depPrivileges = ['nx-repository-view-*-*-add', 'nx-repository-view-*-*-edit', 'nx-component-upload']
def roles = ['developer']
// add roles that uses the developer role as a basis and adds more privileges
security.addRole('deployer', 'Deployer', 'User with privileges to allow deployment all repositories', depPrivileges, roles)
log.info('Role deployer created')

def depRoles = ['deployer']
def lJenkins = security.addUser('jenkins', 'Leeroy', 'Jenkins', 'leeroy.jenkins@example.com', true, 'changMe789', depRoles)
log.info('User jenkins created')

log.info('Script security completed successfully')

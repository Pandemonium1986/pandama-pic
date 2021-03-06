/**
##############
## Security ##
##############
Configure security for nexus 3.
*/

// -- Main

//----------------------
// Disable anonymous access
//----------------------
security.setAnonymousAccess(false)
log.info('Anonymous access disabled')

//----------------------
// Create a new role that allows a user same access as anonymous and adds healtchcheck access
//----------------------
def devPrivileges = ['nx-healthcheck-read', 'nx-healthcheck-summary-read']
def anoRole = ['nx-anonymous']
// add roles that uses the built in nx-anonymous role as a basis and adds more privileges
security.addRole('developer', 'dev', 'User with privileges to allow read access to repo content and healtcheck', devPrivileges, anoRole)
log.info('Role developer created')

//----------------------
// Create new role that allows deployment and create a user to be used on a CI server
//----------------------
// privileges with pattern * to allow any format, browse and read are already part of nx-anonymous
def depPrivileges = ['nx-repository-view-*-*-add', 'nx-repository-view-*-*-edit', 'nx-component-upload']
def roles = ['developer']
// add roles that uses the developer role as a basis and adds more privileges
security.addRole('operational', 'ops', 'User with privileges to allow deployment all repositories', depPrivileges, roles)
log.info('Role operational created')

def depRoles = ['operational']
def Alice = security.addUser('alice', 'Alice', 'Liddell', 'alice@localhost', true, 'password1*', ['developer'])
def Bob = security.addUser('bob', 'Bob', 'Morane', 'bob@localhost', true, 'password1*', depRoles)
def Charlie = security.addUser('charlie', 'Charlie', 'Hebdo', 'charlie@localhost', true, 'password1*', ['developer'])
def Jenkins = security.addUser('jenkins', 'Leeroy', 'Jenkins', 'jenkins@localhost', true, 'password1*', depRoles)
log.info('User jenkins created')


//----------------------
// Modify Admin Password
//----------------------
security.securitySystem.changePassword('admin','password1*')
log.info('Admin password modify')

log.info('Script security completed successfully')

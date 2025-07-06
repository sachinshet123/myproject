public class UserTriggerHandler {
        public static void addToPublicGroup(List<User> newUserList) {
            Id profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
            Id groupId = [SELECT Id FROM Group WHERE DeveloperName = 'Admins'].Id;
            List<GroupMember> grpMemberList = new List<GroupMember>();
            for(User usr : newUserList) {
                if(usr.ProfileId == profileId && usr.IsActive) {
                    GroupMember grpMember = new GroupMember();
                    grpMember.GroupId = groupId;
                    grpMember.UserOrGroupId = usr.Id;
                    grpMemberList.add(grpMember);
                }
            }
            try {
                if(!grpMemberList.isEmpty()) {
                    insert grpMemberList;
                }
            }
            catch (Exception e) {
                System.debug(e.getMessage());
            }
            finally {
                System.debug('All Good');
            }
        }
    }
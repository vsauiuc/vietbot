# Description:
#   Add group to channel.
#
# Board Commands:
#   hubot <board, interns> - Helps add <board> or <interns> to channel.
#
# Author:
#   Hung Pham


module.exports = (robot) ->
    robot.respond /interns?\s*?$/i, (res) ->
        role1 = 'admin'
        role2 = 'board'
        role3 = 'intern'
        messenger = robot.brain.userForName(res.message.user.name)
        unless messenger?
            return res.reply 'You do not exist.'
        unless robot.auth.hasRole(messenger, role1) or robot.auth.hasRole(messenger, role2) or robot.auth.hasRole(messenger, role3)
            return res.reply 'Access Denied. You need role \'' + role1 + ', \'' + role2 + '\', or \'' + role3 + '\' to perform this action.'
        if process.env.INTERN_IDS.length
            retval = 'Copy and paste the list of interns into your chat and send the message. Then, accept all dialogues (Click "Yes, show channel history").\n'
            intern_ids = process.env.INTERN_IDS.split ','
            intern_names = []
            for member_id, i in intern_ids
                user = robot.brain.userForId(member_id)
                intern_names[i] = '@'.concat user.name
            retval += intern_names.join(' ')
            res.send retval
        else
            res.send 'There are no interns at the moment.'

    robot.respond /board\s*?$/i, (res) ->
        role1 = 'admin'
        role2 = 'board'
        role3 = 'intern'
        messenger = robot.brain.userForName(res.message.user.name)
        unless messenger?
            return res.reply 'You do not exist.'
        unless robot.auth.hasRole(messenger, role1) or robot.auth.hasRole(messenger, role2) or robot.auth.hasRole(messenger, role3)
            return res.reply 'Access Denied. You need role \'' + role1 + ', \'' + role2 + '\', or \'' + role3 + '\' to perform this action.'
        retval = 'Copy and paste the list of board members into your chat and send the message. Then, accept all dialogues (Click "Yes, show channel history").\n'
        board_ids = process.env.BOARD_IDS.split ','
        board_names = []
        for member_id, i in board_ids
            user = robot.brain.userForId(member_id)
            board_names[i] = '@'.concat user.name
        retval += board_names.join(' ')
        res.send retval
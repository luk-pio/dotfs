---
model: haiku
---

Create or update a pull request with the changes from this session.

## Steps

1. Run `git status` to check for uncommitted changes and current branch
2. If there are uncommitted changes, stage and commit them with an appropriate message
3. Check if a PR already exists for the current branch using `gh pr view`
4. **If PR exists (updating):**
   - Count commits on this branch vs the base branch
   - If more than one commit, interactively rebase to squash all commits into one with a clear message
   - Force push the changes: `git push --force-with-lease`
   - The existing PR will automatically update
5. **If no PR exists (creating):**
   - Push the branch to origin with `-u` flag
   - Create a new PR using `gh pr create` with:
     - A clear title summarizing the changes
     - A body with Summary and Test plan sections
6. Report the PR URL when done

## Important
- Always use `--force-with-lease` instead of `--force` for safety
- When squashing, preserve the meaningful commit message content
- Never push to main/master directly
- If on main/master branch, ask the user to create a feature branch first

---
sidebar_position: 29
slug: /git-lfs
---

# Git LFS 大文件存储



打开 [git-lfs.github.com](https://git-lfs.github.com/) 页面，下载对应操作系统版本的程序



1. Download and install the Git command line extension. Once downloaded and installed, set up Git LFS for your user account by running:

   ```
   git lfs install
   ```

   You only need to run this once per user account.

2. In each Git repository where you want to use Git LFS, select the file types you'd like Git LFS to manage (or directly edit your .gitattributes). You can configure additional file extensions at anytime.

   ```
   git lfs track "*.psd"
   ```

   Now make sure .gitattributes is tracked:

   ```
   git add .gitattributes
   ```

   Note that defining the file types Git LFS should track will not, by itself, convert any pre-existing files to Git LFS, such as files on other branches or in your prior commit history. To do that, use the [git lfs migrate[1\]](https://github.com/git-lfs/git-lfs/blob/main/docs/man/git-lfs-migrate.1.ronn?utm_source=gitlfs_site&utm_medium=doc_man_migrate_link&utm_campaign=gitlfs) command, which has a range of options designed to suit various potential use cases.

3. There is no step three. Just commit and push to GitHub as you normally would; for instance, if your current branch is named `main`:

   ```
   git add file.psd
   git commit -m "Add design file"
   git push origin main
   ```

   Check out our [wiki](https://github.com/git-lfs/git-lfs/wiki?utm_source=gitlfs_site&utm_medium=wiki_link&utm_campaign=gitlfs), [discussion forum](https://github.com/git-lfs/git-lfs/discussions?utm_source=gitlfs_site&utm_medium=discussions_link&utm_campaign=gitlfs), and [documentation](https://github.com/git-lfs/git-lfs/tree/main/docs?utm_source=gitlfs_site&utm_medium=docs_link&utm_campaign=gitlfs) for help with any questions you might have!


@isTest public class CaseCommentCreatedTriggerTest {
    
	@isTest static void caseCommentAfterInsertTest() {
		Case randomCase = new Case(Subject = 'CaseCommentCreatedTriggerTest');
		insert randomCase;
		CaseComment randomCaseComment = new CaseComment(
			ParentId = randomCase.Id,
			CommentBody = 'In faucibus orci est, vitae dignissim enim commodo a.'
		);
		JCFS.JiraTriggerTestHelper.testAfterInsert(randomCaseComment);
	}
}
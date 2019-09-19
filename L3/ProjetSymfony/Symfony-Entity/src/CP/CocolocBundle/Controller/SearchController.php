<?php
namespace CP\CocolocBundle\Controller;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use CP\CocolocBundle\Entity\commentaire;
use CP\CocolocBundle\Entity\Annonce;
use CP\CocolocBundle\Form\AnnonceType;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use CP\UserBundle\Entity\User;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\Form\Extension\Core\Type\SearchType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\HttpFoundation\Cookie;
use Symfony\Component\Validator\Constraints\Length;


/**
*@Route ("/{_locale}/search")
*/
class SearchController extends Controller{


	/**
     * @Route("/result", name="search_results")
     */

    public function resultsAction(Request $request)
    {
    	
        $em = $this->getDoctrine()->getManager();
        $search = array();
    	$search['Ville']= $request->query->get('Ville');
    	$search['Cat']= $request->query->get('Cat');
    	$search['place_max']= $request->query->get('place_max');
    	$search['place_min']= $request->query->get('place_min');
    	$search['prix_max']= $request->query->get('prix_max');
// Ici on utilise une requête créée dans le repository
        $resultats = $em->getRepository(Annonce::class)->findAnnonce($search);
        $annonce = $this->get('knp_paginator')->paginate($resultats,
		$request->query->get('page',1),4);
         return $this->render('@CPCocoloc/Search/result.html.twig', [
		'Annonce'=>$annonce
	]);

    }








}



?>

<?php

namespace CP\CocolocBundle\Controller;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use CP\CocolocBundle\Entity\Reservation;
use CP\CocolocBundle\Entity\Annonce;


/**
*@Route ("auth/{_locale}/reserv")
*/

class ReservationController extends Controller{


    /**
  * @Route("/add/{id}",name="addreserv")
  * @return Symfony\Component\HttpFoundation\Response
  * @throws \LogicException
  */


    public function newAction(Annonce $annonce, Request $request){


      $exist= false;
      $user= $this->getUser();
      $reservations = $annonce->getReservation();
      $placedispo = $annonce->getnbdispo();

      if ($placedispo == 0 ){

        return $this->redirectToRoute('show',['id'=>$annonce->getId()]);

      }

      else{

          $i=0;
          while ($exist==false and $i< count($reservations)){
              $userReserv = $reservations[$i]->getUser();
              if ($userReserv->getId()==$user->getId()){
                  $exist= true;
            }
            $i++;
          }


          if($exist == false){

            $reserv= new Reservation();
            $placedispo = $placedispo - 1;
            $annonce->setnbdispo($placedispo);
            $reserv->setAnnonce($annonce);
            $reserv->setUser($user);
            $annonce->addReservation($reserv);
            $em = $this->getDoctrine()->getManager();
            $em->persist($reserv);
            $em->flush();
          return $this->redirectToRoute('show',['id'=>$annonce->getId()]);
          }
          else{

            return $this->redirectToRoute('show',['id'=>$annonce->getId()]);


          }
      }
    }


  /**
  * @Route("/delete/{id}", requirements={"id":"\d+"},name="deleteResever")
  */

    public function deleteAction(Reservation $reservations, Request $request){

      $annonce = $reservations->getAnnonce();
      $placedispo = $annonce->getnbdispo()+ 1;
      $annonce->setnbdispo($placedispo);
      $em = $this->getDoctrine()->getManager();
      $em->remove($reservations);
      $em->flush();
      $userManager= $this->get('fos_user.user_manager');
      $user = $userManager->findUsers();
      return $this->redirectToRoute('myAnnonce');
    }

    /**
  * @Route("/accept/{id}", requirements={"id":"\d+"},name="accept")
  */

    public function accpetAction(Reservation $reservations, Request $request){
      $statut = 1;
     $reservations->setStatut($statut);
     $em = $this->getDoctrine()->getManager();
     $em->persist($reservations);
     $em->flush();
      return $this->redirectToRoute('myAnnonce');
    }


}

?>
